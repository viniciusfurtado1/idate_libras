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
        title: const Text(
          "IDATE/LIBRAS",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //const SizedBox(height: 96),
                const Text(
                  "INSTRUÇÕES INICIAIS",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Image.asset('assets/images/video.png'),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const MyHomePage()));
        },
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
