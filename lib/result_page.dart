import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:idate_libras/form_summary.dart';
import 'package:idate_libras/question.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  String classificarPontuacaoIDATE(int score) {
    if (score >= 20 && score <= 40) {
      return "Baixo nível de ansiedade";
    } else if (score >= 41 && score <= 60) {
      return "Médio nível de ansiedade";
    } else if (score >= 61 && score <= 80) {
      return "Alto nível de ansiedade";
    } else {
      return "Pontuação inválida";
    }
  }

  Color corDaClassificacao(String classificacao) {
    switch (classificacao) {
      case "Baixo nível de ansiedade":
        return const Color(0xFF2E7D32); // verde
      case "Médio nível de ansiedade":
        return const Color(0xFFF9A825); // amarelo
      case "Alto nível de ansiedade":
        return const Color(0xFFC62828); // vermelho
      default:
        return const Color(0xFF616161); // cinza para inválido
    }
  }

  /// Um chip pronto pra usar onde quiser
  Widget buildClassificacaoChip(String classificacao) {
    return Chip(
      label: Text(
        classificacao,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: corDaClassificacao(classificacao),
    );
  }

  Future<List<Map<String, dynamic>>> _loadResults() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedResults = prefs.getStringList('idate_results');
    if (savedResults != null) {
      return savedResults
          .map((result) => jsonDecode(result) as Map<String, dynamic>)
          .toList();
    }
    return [];
  }

  Future<void> _clearResults() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('idate_results');
    setState(() {});
  }

  Future<void> _confirmDelete(BuildContext context) async {
    List<Map<String, dynamic>> results = await _loadResults();
    if (results.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('AVISO'),
            content: const Text('Não há resultados para apagar.',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ATENÇÃO'),
            content: const Text(
                'Você realmente deseja apagar todos os resultados?',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancelar',
                    style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Confirmar',
                    style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                onPressed: () {
                  _clearResults();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'IDATE/Libras',
          style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF123068),
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.delete),
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _loadResults(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                  child: Text('Erro ao carregar os resultados.',
                      style: TextStyle(fontSize: 14)));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                  child: Text('Nenhum resultado encontrado.',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)));
            }

            List<Map<String, dynamic>> results = snapshot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'RESULTADOS:',
                    style: TextStyle(
                      fontSize: 20, // Fonte reduzida
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      var result = results[index];
                      final int score = (result['score'] as num).toInt();
                      final String classificacao = classificarPontuacaoIDATE(score);

                      var date = DateTime.parse(result['date']);
                      String twoDigitsMinutes =
                      date.minute.toString().padLeft(2, '0');
                      var formattedDate =
                          '${date.day}/${date.month}/${date.year} às ${date.hour}:$twoDigitsMinutes';

                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          border: Border.all(color: Colors.black, width: 1.0),
                          borderRadius: BorderRadius.circular(25.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultDetailPage(result: result),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(25.0),
                          child: ListTile(
                            title: Text(
                              'Resultado do IDATE-${result['idateType']} em $formattedDate',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Score: $score • $classificacao',
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            trailing: buildClassificacaoChip(classificacao),
                          ),
                        ),
                      );

                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ResultDetailPage extends StatelessWidget {
  final Map<String, dynamic> result;

  const ResultDetailPage({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    List<Question> questions = (result['questions'] as List)
        .map((q) => Question.fromJson(q as Map<String, dynamic>))
        .toList();
    List<int?> selectedAnswers =
    (result['selectedAnswers'] as List).cast<int?>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Resultado'),
        backgroundColor: const Color(0xFF123068),
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FormSummaryIdate(
              idateType: result['idateType'],
              questions: questions,
              selectedAnswers: selectedAnswers,
              score: result['score'] as int,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF123068),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              label: const Text(
                'Voltar',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

