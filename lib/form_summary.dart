import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:idate_libras/question.dart';

class FormSummaryIdate extends StatelessWidget {
  final List<Question> questions;
  final List<int?> selectedAnswers;
  final int score;
  final String idateType;

  const FormSummaryIdate({
    super.key,
    required this.idateType,
    required this.questions,
    required this.selectedAnswers,
    required this.score,
  });

  /// Método responsável por salvar os dados no Firestore.
  Future<void> saveScoreToFirestore(BuildContext context) async {
    try {
      // Obter o usuário autenticado
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        // Mostrar mensagem de erro se o usuário não estiver autenticado
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuário não autenticado! Faça login para salvar.'),
          ),
        );
        return;
      }

      final firestore = FirebaseFirestore.instance;

      // Dados a serem salvos no Firestore
      final data = {
        'userId': user.uid,
        'email': user.email,
        'idateType': idateType,
        'score': score,
        'timestamp': FieldValue.serverTimestamp(),
        'answers': selectedAnswers,
        'questions': questions.map((q) => q.toJson()).toList(),
      };

      // Salvar os dados no Firestore
      await firestore.collection('scores').add(data);

      // Mostrar mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pontuação salva com sucesso no Firebase!'),
        ),
      );
    } catch (e, stackTrace) {
      // Mostrar mensagem de erro em caso de falha
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao salvar no Firebase: $e'),
        ),
      );
      debugPrint('Erro ao salvar no Firebase: $e');
      debugPrint('StackTrace: $stackTrace');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Chamar o salvamento ao exibir a página
    WidgetsBinding.instance.addPostFrameCallback((_) {
      saveScoreToFirestore(context);
    });

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'IDATE-$idateType/Libras',
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Container(
        color: const Color(0xFFF6F6F6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'RESULTADOS',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'IDATE-$idateType',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'SCORE: $score',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];
                  final selectedAnswer = selectedAnswers[index];

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Text(
                            question.questionText,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List<Widget>.generate(
                              question.options.length,
                                  (i) {
                                return Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child: Text(
                                        question.options[i],
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 1.5,
                                      child: Radio<int>(
                                        value: i,
                                        groupValue: selectedAnswer,
                                        onChanged: null,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
