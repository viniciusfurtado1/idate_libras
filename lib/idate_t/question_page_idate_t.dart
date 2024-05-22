import 'package:flutter/material.dart';
import 'package:idate_libras/idate_t/form_summary_idate_t.dart';
import 'package:idate_libras/question.dart';

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

  static const options = [
    'QUASE NUNCA',
    'ÀS VEZES',
    'FREQUENTEMENTE',
    ' QUASE SEMPRE'
  ];
  static const weights = [1, 2, 3, 4];
  static const reverseWeights = [4, 3, 2, 1];

  final List<Question> _questions = [
    Question(
        questionText: '1. SENTIR BEM',
        videoAsset: 'assets/images/video.png',
        options: options,
        weights: reverseWeights),
    Question(
        questionText: '2. CANSAR RÁPIDO',
        videoAsset: 'assets/images/video.png',
        options: options,
        weights: weights),
    Question(
        questionText: '3. SENTIR VONTADE CHORAR',
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
          builder: (context) => FormSummaryIdateT(
                questions: _questions,
                selectedAnswers: _selectedAnswers,
                score: score,
              )),
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
        title: const Text('IDATE-T/LIBRAS'),
        //${_currentPage + 1} de ${_questions.length}'
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        itemCount: _questions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 96), // ajustar a altura aqui
                Text(
                  _questions[index].questionText,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 24),
                Image.asset(_questions[index].videoAsset),
                const SizedBox(height: 24),

                Wrap(
                  spacing: 1,
                  runSpacing: 1,
                  children: List<Widget>.generate(
                      _questions[index].options.length, (i) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            border: Border.all(
                              color: Colors.white,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                              '${i + 1} \n ${_questions[index].options[i]}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 11.6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
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
              shape: const CircleBorder(),
              backgroundColor: _isNextButtonEnabled()
                  ? Theme.of(context).colorScheme.inversePrimary
                  : Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.check),
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
