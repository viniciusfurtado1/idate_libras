import 'package:flutter/material.dart';
import 'package:idate_libras/home_page.dart';
import 'package:idate_libras/question.dart';

class FormSummaryIdateT extends StatelessWidget {
  final List<Question> questions;
  final List<int?> selectedAnswers;
  final int score;

  const FormSummaryIdateT(
      {super.key,
      required this.questions,
      required this.selectedAnswers,
      required this.score});

  @override
  Widget build(BuildContext context) {
    // Aqui você pode criar a tela de resumo do formulário
    return Scaffold(
      appBar: AppBar(
        title: const Text('IDATE-T/LIBRAS'),
        //${_currentPage + 1} de ${_questions.length}'
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage()),
            );
          },
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  const Text(
                    'IDATE-T',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                              question.options.length, (i) {
                            return Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    //color: Theme.of(context).colorScheme.primary,
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Text(question.options[i],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      )),
                                ),
                                Transform.scale(
                                  scale:
                                      1.5, // Aumenta o tamanho do círculo do Radio
                                  child: Radio<int>(
                                    value: i,
                                    groupValue: selectedAnswer,
                                    onChanged: null, // Desabilitado
                                    
                                    
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ],
                    ),
                  );
                }))
      ]),
    );
  }
}
