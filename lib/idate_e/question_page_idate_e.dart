import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:idate_libras/home_page.dart';
import 'package:idate_libras/question.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionPageIdateE extends StatefulWidget {
  const QuestionPageIdateE({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuestionPageIdateT createState() => _QuestionPageIdateT();
}

class _QuestionPageIdateT extends State<QuestionPageIdateE> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  List<int?> _selectedAnswers = [];

  static const options = [
    'ABSOLUTAMENTE NÃO',
    'UM POUCO',
    'BASTANTE',
    'MUITÍSSIMO'
  ];
  static const weights = [1, 2, 3, 4];
  static const reverseWeights = [4, 3, 2, 1];

  final List<Question> _questions = [
    Question(
        questionText: '1. SENTIR CALMO',
        videoAsset: 'assets/images/video.png',
        options: options,
        weights: reverseWeights),
    Question(
        questionText: '2. SENTIR SEGURO',
        videoAsset: 'assets/images/video.png',
        options: options,
        weights: reverseWeights),
    Question(
        questionText: '3. ESTAR PRECIONADO',
        videoAsset: 'assets/images/video.png',
        options: options,
        weights: weights),
  ];

  @override
  void initState() {
    super.initState();
    _selectedAnswers = List<int?>.filled(_questions.length, null);
  }

  void _nextPage() {
    if (_currentPage < _questions.length - 1) {
      setState(() {
        _currentPage++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _goToHomePage() async {
    await _saveResult();
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Formulário concluído com sucesso!',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        duration: Duration(seconds: 3), // duração da notificação
      ),
    );
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  Future<void> _saveResult() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedResults = prefs.getStringList('idate_results');
    savedResults ??= [];

    final result = {
      'idateType': "E",
      'date': DateTime.now().toIso8601String(),
      'questions': _questions.map((q) => q.toJson()).toList(),
      'selectedAnswers': _selectedAnswers,
      'score': _calcScore(),
    };

    savedResults.add(jsonEncode(result));
    await prefs.setStringList('idate_results', savedResults);
  }

  int _calcScore() {
    int score = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_selectedAnswers[i] != null) {
        score += _questions[i].weights[_selectedAnswers[i]!];
      }
    }
    return score;
  }

  void _onOptionSelected(int questionIndex, int? selectedIndex) {
    setState(() {
      _selectedAnswers[questionIndex] = selectedIndex;
    });
  }

  bool _isLastQuestion() {
    return _currentPage == _questions.length - 1;
  }

  bool _isNextButtonEnabled() {
    // Verifica se alguma opção foi selecionada para a pergunta atual
    return _selectedAnswers[_currentPage] != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IDATE-E/LIBRAS',
            style: TextStyle(fontWeight: FontWeight.bold)),
        //${_currentPage + 1} de ${_questions.length}'
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        itemCount: _questions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(1.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 96), // ajustar a altura aqui
                Text(
                  textAlign: TextAlign.start,
                  _questions[index].questionText,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 24),
                Image.asset(_questions[index].videoAsset),
                const SizedBox(height: 30),

                Center(
                  child: Wrap(
                    alignment: WrapAlignment.spaceAround,
                    spacing: 1,
                    //runSpacing: 1,
                    children: List<Widget>.generate(
                        _questions[index].options.length, (i) {
                      return Column(
                        children: [
                          Container(
                            //width: 114,
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            height: 50,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(25.0),
                            ),

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('${i + 1}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                                Text(_questions[index].options[i],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                          Transform.scale(
                            scale: 1.5, // Aumenta o tamanho do círculo do Radio

                            child: Radio<int>(
                              value: i,
                              groupValue: _selectedAnswers[index],
                              onChanged: (value) =>
                                  _onOptionSelected(index, value),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
        },
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
      floatingActionButton: _isLastQuestion()
          ? FloatingActionButton(
              onPressed: _isNextButtonEnabled() ? _goToHomePage : null,
              shape: const CircleBorder(),
              backgroundColor:
                  _isNextButtonEnabled() ? Colors.green : Colors.green.shade300,
              child: const Icon(Icons.check, size: 30.0),
            )
          : FloatingActionButton(
              onPressed: _isNextButtonEnabled() ? _nextPage : null,
              shape: const CircleBorder(),
              backgroundColor: _isNextButtonEnabled()
                  ? Theme.of(context).colorScheme.inversePrimary
                  : Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.arrow_forward),
            ),
    );
  }
}
