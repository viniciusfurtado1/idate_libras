import 'package:flutter/material.dart';
import 'package:idate_libras/idate_t/question_page_idate_t.dart';

class IdateTInstrucoes extends StatefulWidget {
  const IdateTInstrucoes({super.key});

  @override
  State<IdateTInstrucoes> createState() => _IdateTInstrucoesState();
}

class _IdateTInstrucoesState extends State<IdateTInstrucoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          "IDATE-T/LIBRAS",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //const SizedBox(height: 96),
              const Text(
                "IDATE-T/LIBRAS INSTRUÇÕES",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Image.asset('assets/images/video.png'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const QuestionPageIdateT()));
        },
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
