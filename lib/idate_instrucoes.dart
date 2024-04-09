import 'package:flutter/material.dart';
import 'package:idate_libras/idate_e.dart';
import 'package:idate_libras/idate_t.dart';
import 'package:idate_libras/idate_t_e.dart';

class IdateInstrucoes extends StatefulWidget {
  String telaAnterior;
  IdateInstrucoes({super.key, required this.telaAnterior});

  @override
  State<IdateInstrucoes> createState() => _IdateInstrucoesState();
}

class _IdateInstrucoesState extends State<IdateInstrucoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("IDATE LIBRAS"),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 400),
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
                "Instruções",
                style: TextStyle(fontSize: 20),
              ),
              Image.asset('assets/images/video.png'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {if (widget.telaAnterior == "idatet") {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => IdateT()));
          } else if (widget.telaAnterior == "idatee") {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => IdateE()));
          } else if (widget.telaAnterior == "idatetee") {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => IdateTeE()));
          }},
        shape: CircleBorder(),
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
