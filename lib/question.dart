import 'package:flutter/material.dart';

class Question {
  final String questionText;
  final String videoAsset;
  final List<String> options;

  Question({required this.questionText, required this.videoAsset, required this.options});
}