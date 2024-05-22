import 'package:flutter/material.dart';
import 'package:idate_libras/idate_e/idate_e.dart';
import 'package:idate_libras/idate_instrucoes.dart';
import 'package:idate_libras/idate_t_e/idate_t_e.dart';
import 'package:idate_libras/idate_t/idate_t_intrucoes.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SingingCharacter? _character = SingingCharacter.idatet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const IdateInstrucoes()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        title: const Text("IDATE/LIBRAS"),
        actions: [
          IconButton( // Adiciona um IconButton à AppBar
            color: Colors.white,
            icon: const Icon(Icons.article), // Ícone para o botão
            onPressed: () {
               
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "SELECIONE O FORMULÁRIO:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Transform.scale(
                  scale: 1.5,
                  child: Radio<SingingCharacter>(
                    value: SingingCharacter.idatet,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16.0),
                const Text(
                  'IDATE-T',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Transform.scale(
                  scale: 1.5,
                  child: Radio<SingingCharacter>(
                    value: SingingCharacter.idatee,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16.0),
                const Text(
                  'IDATE-E',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Transform.scale(
                  scale: 1.5,
                  child: Radio<SingingCharacter>(
                    value: SingingCharacter.idatete,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16.0),
                const Text(
                  'IDATE-T e IDATE-E',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_character == SingingCharacter.idatet) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const IdateTInstrucoes()));
          } else if (_character == SingingCharacter.idatee) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => IdateE()));
          } else if (_character == SingingCharacter.idatete) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => IdateTeE()));
          }
        },
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: const Icon(Icons.arrow_forward),
      ),
      
    );
  }
}

enum SingingCharacter { idatet, idatee, idatete }
