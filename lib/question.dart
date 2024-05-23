class Question {
  final String questionText;
  final String videoAsset;
  final List<String> options;
  final List<int> weights;

  Question(
      {required this.questionText,
      required this.videoAsset,
      required this.options,
      required this.weights});

  Map<String, dynamic> toJson() => {
        'questionText': questionText,
        'videoAsset': videoAsset,
        'options': options,
        'weights': weights,
      };

  static Question fromJson(Map<String, dynamic> json) => Question(
        questionText: json['questionText'],
        videoAsset: json['videoAsset'],
        options: List<String>.from(json['options']),
        weights: List<int>.from(json['weights']),
      );
}
