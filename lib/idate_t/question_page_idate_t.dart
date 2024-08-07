import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:idate_libras/question.dart';
import 'package:idate_libras/question_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionPageIdateT extends StatefulWidget {
  const QuestionPageIdateT({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuestionPageIdateT createState() => _QuestionPageIdateT();
}

class _QuestionPageIdateT extends State<QuestionPageIdateT> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  List<int?> _selectedAnswers = [];

  @override
  void initState() {
    super.initState();
    _selectedAnswers = List<int?>.filled(_questions.length, null);
  }

  static const options = [
    'QUASE NUNCA',
    'ÀS VEZES',
    'FREQUENTEMENTE',
    'QUASE SEMPRE'
  ];
  static const weights = [1, 2, 3, 4];
  static const reverseWeights = [4, 3, 2, 1];

  final List<Question> _questions = [
    Question(
        questionText: '1. SENTIR BEM',
        videoAsset: 'assets/videos/idatet/T-1.mp4',
        options: options,
        weights: reverseWeights),
    Question(
        questionText: '2. CANSAR RÁPIDO',
        videoAsset: 'assets/videos/idatet/T-2.mp4',
        options: options,
        weights: weights),
    Question(
        questionText: '3. SENTIR VONTADE CHORAR',
        videoAsset: 'assets/videos/idatet/T-3.mp4',
        options: options,
        weights: weights),
    Question(
        questionText: '4. QUERER SER FELIZ IGUAL PESSOAS VEJO',
        videoAsset: 'assets/videos/idatet/T-4.mp4',
        options: options,
        weights: weights),
    Question(
        questionText: '5. PERDER OPORTUNIDADE PORQUE EU NÃO CONSEGUIR DECIDIR RÁPIDO',
        videoAsset: 'assets/videos/idatet/T-5.mp4',
        options: options,
        weights: weights),
    Question(
        questionText: '6. SENTIR RELAXAR',
        videoAsset: 'assets/videos/idatet/T-6.mp4',
        options: options,
        weights: reverseWeights),
    Question(
        questionText: '7. SENTIR CALMO CONFIANÇA PRÓPRIO',
        videoAsset: 'assets/videos/idatet/T-7.mp4',
        options: options,
        weights: reverseWeights),
    Question(
        questionText: '8. SENTIR DIFÍCIL RESOLVER MUITAS COISAS',
        videoAsset: 'assets/videos/idatet/T-8.mp4',
        options: options,
        weights: weights),
    Question(
        questionText: '9. PREOCUPAR COISAS NÃO TER IMPORTÂNCIA',
        videoAsset: 'assets/videos/idatet/T-9.mp4',
        options: options,
        weights: weights),
    Question(
        questionText: '10. SER FELIZ',
        videoAsset: 'assets/videos/idatet/T-10.mp4',
        options: options,
        weights: reverseWeights),
    Question(
        questionText: '11. ABSORVER PROBLEMAS',
        videoAsset: 'assets/videos/idatet/T-11.mp4',
        options: options,
        weights: weights),
    Question(
        questionText: '12. DENTRO PRÓPRIO CONFIANÇA NÃO TER',
        videoAsset: 'assets/videos/idatet/T-12.mp4',
        options: options,
        weights: weights),
    Question(
        questionText: '13. SENTIR SEGURO',
        videoAsset: 'assets/videos/idatet/T-13.mp4',
        options: options,
        weights: reverseWeights),
    Question(
        questionText: '14. EVITAR PROBLEMAS',
        videoAsset: 'assets/videos/idatet/T-14.mp4',
        options: options,
        weights: weights),
    Question(
        questionText: '15. SENTIR DEPRIMIDO',
        videoAsset: 'assets/videos/idatet/T-15.mp4',
        options: options,
        weights: weights),
    Question(
        questionText: '16. SENTIR SATISFEITO',
        videoAsset: 'assets/videos/idatet/T-16.mp4',
        options: options,
        weights: reverseWeights),
    Question(
        questionText: '17. IDEIAS PENSAR BOBAS FICAR CABEÇA COMEÇAR PREOCUPAR',
        videoAsset: 'assets/videos/idatet/T-17.mp4',
        options: options,
        weights: weights),
    Question(
        questionText: '18. PENSAR NEGATIVO DESAPONTADO NÃO CONSEGUIR ESQUECER',
        videoAsset: 'assets/videos/idatet/T-18.mp4',
        options: options,
        weights: weights),
    Question(
        questionText: '19. SER PESSOA IGUAL',
        videoAsset: 'assets/videos/idatet/T-19.mp4',
        options: options,
        weights: reverseWeights),
  Question(
        questionText: '20. PERTUBADO PENSAR PROBLEMAS AGORA',
        videoAsset: 'assets/videos/idatet/T-20.mp4',
        options: options,
        weights: weights),
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
        duration: Duration(seconds: 3),
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
      'idateType': "T",
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
          'IDATE-T/Libras',
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
