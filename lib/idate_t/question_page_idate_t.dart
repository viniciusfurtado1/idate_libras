import 'package:flutter/material.dart';
import 'package:idate_libras/idate_t/form_summary_idate_t.dart';
import 'package:idate_libras/question.dart';

class QuestionPageIdateT extends StatefulWidget {
  @override
  _QuestionPageIdateT createState() => _QuestionPageIdateT();
}

class _QuestionPageIdateT extends State<QuestionPageIdateT> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  List<int?> _selectedAnswers = [];

  final List<Question> _questions = [
    Question(
        questionText: '1. SENTIR BEM',
        videoAsset: 'assets/images/video.png',
        options: ['QUASE NUNCA', 'ÀS VEZES', 'FREQUENTEMENTE', ' QUASE SEMPRE'],
        weights: [4, 3, 2, 1]),
    Question(
        questionText: '2. CANSAR RÁPIDO',
        videoAsset: 'assets/images/video.png',
        options: ['QUASE NUNCA', 'ÀS VEZES', 'FREQUENTEMENTE', ' QUASE SEMPRE'],
        weights: [1, 2, 3, 4]),
    Question(
        questionText: '3. SENTIR VONTADE CHORAR',
        videoAsset: 'assets/images/video.png',
        options: ['QUASE NUNCA', 'ÀS VEZES', 'FREQUENTEMENTE', ' QUASE SEMPRE'],
        weights: [1, 2, 3, 4]),
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
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _goToSummary() {
    int score = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_selectedAnswers[i] != null) {
        score += _questions[i].weights[_selectedAnswers[i]!];
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FormSummaryIdateT (
              questions: _questions, selectedAnswers: _selectedAnswers,  score: score,)),
    );
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
        title: Text('IDATE-T/LIBRAS'),
        //${_currentPage + 1} de ${_questions.length}'
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        itemCount: _questions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 96), // ajustar a altura aqui
                Text(
                  _questions[index].questionText,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 24),
                Image.asset(_questions[index].videoAsset),
                SizedBox(height: 24),

                Wrap(
                  spacing: 1,
                  runSpacing: 1,
                  children: List<Widget>.generate(
                      _questions[index].options.length, (i) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_questions[index].options[i],
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
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
              onPressed: _isNextButtonEnabled() ? _goToSummary : null,
              shape: CircleBorder(),
              child: Icon(Icons.check),
              backgroundColor: _isNextButtonEnabled()
                  ? Colors.green
                  : Colors.green.withOpacity(0.5),
            )
          : FloatingActionButton(
              onPressed: _isNextButtonEnabled() ? _nextPage : null,
              shape: CircleBorder(),
              child: Icon(Icons.arrow_forward),
              backgroundColor: _isNextButtonEnabled()
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.inversePrimary,
            ),
    );
  }
}
