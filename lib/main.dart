import 'package:flutter/material.dart';
import 'package:idate_libras/welcome_page.dart'; // Import da nova tela inicial

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 76, 147),
        ),
      ),
      home: const WelcomePage(), // Início da navegação com a WelcomePage
    );
  }
}
