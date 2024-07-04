import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:idate_libras/form_summary.dart';
import 'package:idate_libras/question.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
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
            title: const Text('Aviso'),
            content: const Text('Não há resultados para apagar.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancelar',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Confirmar',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
          color: Colors.white, // Defina a cor desejada aqui
        ),
        title: const Text(
          'IDATE/Libras',
          style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.delete), // Ícone para o botão
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFFF6F6F6),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _loadResults(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                  child: Text('Erro ao carregar os resultados.'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                  child: Text('Nenhum resultado encontrado.',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)));
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
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      var result = results[index];
                      var date = DateTime.parse(result['date']);
                      String twoDigitsMinutes =
                          date.minute.toString().padLeft(2, '0');
                      var formattedDate =
                          '${date.day}/${date.month}/${date.year} às ${date.hour}:$twoDigitsMinutes';
                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5), // Cor de fundo
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(25.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(
                                  2, 2), // Alterne a posição da sombra
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ResultDetailPage(result: result),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(25.0),
                          child: ListTile(
                            title: Text(
                              'Resultado do IDATE-${result['idateType']} em $formattedDate',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Score: ${result['score']}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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

    return FormSummaryIdate(
      idateType: result['idateType'],
      questions: questions,
      selectedAnswers: selectedAnswers,
      score: result['score'] as int,
    );
  }
}
