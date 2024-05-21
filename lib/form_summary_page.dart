import 'package:flutter/material.dart';
import 'package:idate_libras/home_page.dart';
import 'package:idate_libras/question.dart';

class FormSummaryPage extends StatelessWidget {
  final List<Question> questions;
  final List<int?> selectedAnswers;
  final int score;

  const FormSummaryPage(
      {Key? key, required this.questions, required this.selectedAnswers, required this.score,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Aqui você pode criar a tela de resumo do formulário
    return Scaffold(
      appBar: AppBar(
        title: Text('IDATE-T/LIBRAS'),
        //${_currentPage + 1} de ${_questions.length}'
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          },
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
         Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RESULTADOS',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'IDATE-T',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'SCORE: $score',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                        SizedBox(height: 10),
                        Text(
                          question.questionText,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List<Widget>.generate(
                              question.options.length, (i) {
                            return Column(
                              children: [
                                Text(question.options[i],
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
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
