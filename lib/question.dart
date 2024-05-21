import 'package:flutter/material.dart';

class Question {
  final String questionText;
  final String videoAsset;
  final List<String> options;
  final List<int> weights;

  Question({required this.questionText, required this.videoAsset, required this.options, required this.weights});
}