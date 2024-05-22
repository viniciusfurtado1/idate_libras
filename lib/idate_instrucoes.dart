import 'package:flutter/material.dart';
import 'package:idate_libras/home_page.dart';

class IdateInstrucoes extends StatefulWidget {
  const IdateInstrucoes({super.key});

  @override
  State<IdateInstrucoes> createState() => _IdateInstrucoesState();
}

class _IdateInstrucoesState extends State<IdateInstrucoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("IDATE/LIBRAS"),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 400),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            //color: Theme.of(context).colorScheme.inversePrimary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "INSTRUÇÕES INICIAIS",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Image.asset('assets/images/video.png'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const MyHomePage()));
        },
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
