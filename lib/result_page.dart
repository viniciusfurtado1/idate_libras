import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:idate_libras/idate_t/form_summary_idate_t.dart';
import 'package:idate_libras/question.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RESULTADOS'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.delete), // Ícone para o botão
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadResults(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar os resultados.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum resultado encontrado.'));
          }

          List<Map<String, dynamic>> results = snapshot.data!;

          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              var result = results[index];
              var date = DateTime.parse(result['date']);
              var formattedDate =
                  '${date.day}/${date.month}/${date.year} às ${date.hour}:${date.minute}';
              return ListTile(
                title: Text('Resultado do IDATE-T em $formattedDate'),
                subtitle: Text('Score: ${result['score']}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultDetailPage(result: result),
                    ),
                  );
                },
              );
            },
          );
        },
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

    return FormSummaryIdateT(
      questions: questions,
      selectedAnswers: selectedAnswers,
      score: result['score'] as int,
    );
  }
}
