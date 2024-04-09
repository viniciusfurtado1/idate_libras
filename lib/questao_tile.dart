import 'package:flutter/material.dart';

class QuestaoTile extends StatelessWidget {
  final String questao;
  final SingingCharacter? selectedValue;
  final ValueChanged<SingingCharacter?>? onChanged;

  QuestaoTile(
      {super.key, required this.questao, this.selectedValue, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              questao,
              style: TextStyle(fontSize: 20),
            ),
            Image.asset('assets/images/video.png'),
            RadioListTile<SingingCharacter>(
              title: const Text('Quase sempre'),
              value: SingingCharacter.quasenunca,
              groupValue: selectedValue,
              onChanged: onChanged,
            ),
            RadioListTile<SingingCharacter>(
              title: const Text('Às vezes'),
              value: SingingCharacter.asvezes,
              groupValue: selectedValue,
              onChanged: onChanged,
            ),
            RadioListTile<SingingCharacter>(
              title: const Text('Frequentemente'),
              value: SingingCharacter.frequentemente,
              groupValue: selectedValue,
              onChanged: onChanged,
            ),
            RadioListTile<SingingCharacter>(
              title: const Text('Quase sempre'),
              value: SingingCharacter.quasesempre,
              groupValue: selectedValue,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}

enum SingingCharacter { quasenunca, asvezes, frequentemente, quasesempre }
