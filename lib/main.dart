import 'package:flutter/material.dart';
import 'package:idate_libras/home_page.dart';
import 'package:idate_libras/idate_instrucoes.dart';
import 'package:google_fonts/google_fonts.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        textTheme:  GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: IdateInstrucoes()
    );
  }
}
