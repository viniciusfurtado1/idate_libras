import 'package:flutter/material.dart';
import 'package:idate_libras/idate_e.dart';
import 'package:idate_libras/idate_instrucoes.dart';
import 'package:idate_libras/idate_t.dart';
import 'package:idate_libras/idate_t_e.dart';

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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("IDATE LIBRAS"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RadioListTile<SingingCharacter>(
            title: const Text('IDATE-T'),
            value: SingingCharacter.idatet,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
          RadioListTile<SingingCharacter>(
            title: const Text('IDATE-E'),
            value: SingingCharacter.idatee,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
          RadioListTile<SingingCharacter>(
            title: const Text('IDATE-T E IDATE-E'),
            value: SingingCharacter.idatete,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_character == SingingCharacter.idatet) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => IdateInstrucoes(telaAnterior: "idatet")));
          } else if (_character == SingingCharacter.idatee) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => IdateInstrucoes(telaAnterior: "idatee")));
          } else if (_character == SingingCharacter.idatete) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => IdateInstrucoes(telaAnterior: "idatetee")));
          }
        },
        shape: CircleBorder(),
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}

enum SingingCharacter { idatet, idatee, idatete }
