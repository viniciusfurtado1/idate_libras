import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:idate_libras/question.dart';
import 'package:idate_libras/question_widget.dart';
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

  @override
  void initState() {
    super.initState();
    _selectedAnswers = List<int?>.filled(_questions.length, null);
  }

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
        videoAsset: 'assets/videos/idatee/E-1.mp4',
        options: options,
        weights: reverseWeights),
    Question(
        questionText: '2. SENTIR SEGURO',
        videoAsset: 'assets/videos/idatee/E-2.mp4',
        options: options,
        weights: reverseWeights),
    Question(
        questionText: '3. ESTAR PRECIONADO',
        videoAsset: 'assets/videos/idatee/E-3.mp4',
        options: options,
        weights: weights),
    Question(
        questionText: '4. ARREPENDER',
        videoAsset: 'assets/videos/idatee/E-4.mp4',
        options: options,
        weights: weights),
    Question(
        questionText: '5. SENTIR LIVRE',
        videoAsset: 'assets/videos/idatee/E-5.mp4',
        options: options,
        weights: reverseWeights),
    Question(
        questionText: '6. SENTIR PERTUBADO',
        videoAsset: 'assets/videos/idatee/E-6.mp4',
        options: options,
        weights: weights),
    Question(
        questionText: '7. PREOCUPAR FUTURO QUANDO ACONTECER COISAS RUINS',
        videoAsset: 'assets/videos/idatee/E-7.mp4',
        options: options,
        weights: weights),
    Question(
        questionText: '8. SENTIR DESCANSAR',
        videoAsset: 'assets/videos/idatee/E-8.mp4',
        options: options,
        weights: reverseWeights),
    Question(
        questionText: '9. SENTIR ANSIOSO',
        videoAsset: 'assets/videos/idatee/E-9.mp4',
        options: options,
        weights: weights),
    Question(
        questionText: '10. SENTIR BEM CASA',
        videoAsset: 'assets/videos/idatee/E-10.mp4',
        options: options,
        weights: reverseWeights),
    Question(
        questionText: '11. SENTIR CONFIANÇA',
        videoAsset: 'assets/videos/idatee/E-11.mp4',
        options: options,
        weights: reverseWeights),
    Question(
        questionText: '12. SENTIR NERVOSO',
        videoAsset: 'assets/videos/idatee/E-12.mp4',
        options: options,
        weights: weights),
    Question(
        questionText: '13. SENTIR AGITADO',
        videoAsset: 'assets/videos/idatee/E-13.mp4',
        options: options,
        weights: weights),
    Question(
        questionText: '14. SENTIR MUITO NERVOSO',
        videoAsset: 'assets/videos/idatee/E-14.mp4',
        options: options,
        weights: weights),
    Question(
        questionText: '15. SENTIR LEVE',
        videoAsset: 'assets/videos/idatee/E-15.mp4',
        options: options,
        weights: reverseWeights),
    Question(
        questionText: '16. SATISFEITO',
        videoAsset: 'assets/videos/idatee/E-16.mp4',
        options: options,
        weights: reverseWeights),
    Question(
        questionText: '17. SENTIR PREOCUPAR',
        videoAsset: 'assets/videos/idatee/E-17.mp4',
        options: options,
        weights: weights),
    Question(
        questionText: '18. SENTIR PREOCUPAR EXAUASTO CONFUSO',
        videoAsset: 'assets/videos/idatee/E-18.mp4',
        options: options,
        weights: weights),
    Question(
        questionText: '19. SENTIR ALEGRE',
        videoAsset: 'assets/videos/idatee/E-19.mp4',
        options: options,
        weights: reverseWeights),
    Question(
        questionText: '20. SENTIR BEM',
        videoAsset: 'assets/videos/idatee/E-20.mp4',
        options: options,
        weights: reverseWeights),
  ];

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
    return _selectedAnswers[_currentPage] != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Defina a cor desejada aqui
        ),
        title: const Text(
          'IDATE-E/Libras',
          style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        itemCount: _questions.length,
        itemBuilder: (context, index) {
          return QuestionWidget(
            question: _questions[index],
            selectedAnswer: _selectedAnswers[index],
            onOptionSelected: (selectedIndex) {
              _onOptionSelected(index, selectedIndex);
            },
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
              child: const Icon(Icons.check, size: 32.0),
            )
          : FloatingActionButton(
              onPressed: _isNextButtonEnabled() ? _nextPage : null,
              shape: const CircleBorder(),
              backgroundColor: _isNextButtonEnabled()
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.inversePrimary,
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
    );
  }
}
