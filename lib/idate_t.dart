import 'package:flutter/material.dart';
import 'package:idate_libras/questao_tile.dart';

class IdateT extends StatefulWidget {
  const IdateT({Key? key}) : super(key: key);

  @override
  State<IdateT> createState() => _IdateTState();
}

class _IdateTState extends State<IdateT> {
  Map<int, SingingCharacter?> _selectedValues = {};

  final List<String> _questions = [
    "1. Sentir bem",
    "2. Cansar rápido",
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0;
  List<int?> _selectedAnswers = [];

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

  @override
  Widget build(BuildContext context) {
    bool allQuestionsAnswered = _selectedValues.length == _questions.length &&
        _selectedValues.values.every((value) => value != null);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("IDATE-T"),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: _questions.length,
              itemBuilder: (context, index) {
                return QuestaoTile(
                  questao: _questions[index],
                  selectedValue: _selectedValues[index],
                  onChanged: (value) {
                    setState(() {
                      _selectedValues[index] = value;
                    });
                  },
                );
              },
            ),
          ),
          if (allQuestionsAnswered)
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Coloque aqui a lógica para o que deve acontecer quando o botão for pressionado
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.green, // Mudando a cor do botão para verde
                    ),
                    child: Text('Confirmar', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
        ],
      ),
      floatingActionButton:FloatingActionButton(
        shape: CircleBorder(),
        onPressed: _nextPage,
        child: Icon(Icons.arrow_forward),
        backgroundColor: Theme.of(context).colorScheme.primary,
      )
    );
  }
}

