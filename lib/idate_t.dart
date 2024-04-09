import 'package:flutter/material.dart';
import 'package:idate_libras/questao_tile.dart';

class IdateT extends StatefulWidget {
  const IdateT({Key? key}) : super(key: key);

  @override
  State<IdateT> createState() => _IdateTState();
}

class _IdateTState extends State<IdateT> {
  Map<int, SingingCharacter?> _selectedValues = {};

  final List<String> questoes = [
    "1. Sentir bem",
    "2. Cansar rápido",
    "3. Sentir vontade chorar",
    "4. Querer ser feliz igual pessoas vejo",
    "5. Perder oportunidade porque eu não conseguir decidir rápido"
  ];

  @override
  Widget build(BuildContext context) {
    bool allQuestionsAnswered = _selectedValues.length == questoes.length &&
        _selectedValues.values.every((value) => value != null);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("IDATE-T"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: questoes.length,
              itemBuilder: (context, index) {
                return QuestaoTile(
                  questao: questoes[index],
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
    );
  }
}
