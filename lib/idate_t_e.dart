import 'package:flutter/material.dart';

class IdateTeE extends StatefulWidget {
  const IdateTeE({super.key});

  @override
  State<IdateTeE> createState() => _IdateTeEState();
}

class _IdateTeEState extends State<IdateTeE> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("IDATE-T e IDATE-E"),
      ),
      
    );
  }
}