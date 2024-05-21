import 'package:flutter/material.dart';

class IdateE extends StatefulWidget {
  const IdateE({super.key});

  @override
  State<IdateE> createState() => _IdateEState();
}

class _IdateEState extends State<IdateE> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("IDATE-E"),
      ),
    );
  }
}
