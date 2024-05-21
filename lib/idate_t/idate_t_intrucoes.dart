import 'package:flutter/material.dart';
import 'package:idate_libras/idate_t/question_page_idate_t.dart';

class IdateTInstrucoes extends StatefulWidget {
  IdateTInstrucoes({super.key});

  @override
  State<IdateTInstrucoes> createState() => _IdateTInstrucoesState();
}

class _IdateTInstrucoesState extends State<IdateTInstrucoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("IDATE/LIBRAS"),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 400),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            //color: Theme.of(context).colorScheme.inversePrimary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("INSTRUÇÕES IDATE-T", style: TextStyle(fontSize: 20),),

              Image.asset('assets/images/video.png'),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => QuestionPageIdateT()));
        },
        shape: CircleBorder(),
        child: const Icon(Icons.arrow_forward),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}