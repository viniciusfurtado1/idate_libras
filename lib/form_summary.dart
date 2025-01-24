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
  Future<void> saveScoreToFirestore(BuildContext context, User user) async {
    try {
      final firestore = FirebaseFirestore.instance;

      // Dados a serem salvos no Firestore
      final data = {
        'userId': user.uid,
        'email': user.email,
        'name': user.displayName ?? 'Nome não fornecido', // Aqui você pega o nome do usuário
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
        ),
      body: FutureBuilder<User?>(
        future: FirebaseAuth.instance.authStateChanges().first,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = snapshot.data;

          if (user == null) {
            // Mostrar mensagem de erro se o usuário não estiver autenticado
            return const Center(
              child: Text('Usuário não autenticado! Faça login para continuar.'),
            );
          }

          // Chama o salvamento no Firestore logo após a página ser carregada
          WidgetsBinding.instance.addPostFrameCallback((_) {
            saveScoreToFirestore(context, user);
          });

          return Container(
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
                                              fontSize: 12,
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
