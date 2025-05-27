import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:idate_libras/question.dart';
import 'package:video_player/video_player.dart';

class QuestionWidget extends StatefulWidget {
  final Question question;
  final int? selectedAnswer;
  final ValueChanged<int?> onOptionSelected;

  const QuestionWidget({
    super.key,
    required this.question,
    required this.selectedAnswer,
    required this.onOptionSelected,
  });

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
        videoPlayerController:
        VideoPlayerController.asset(widget.question.videoAsset));
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView( // Adicionado para evitar overflow
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Text(
              widget.question.questionText,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: FlickVideoPlayer(flickManager: flickManager),
              ),
            ),
            const SizedBox(height: 32),

            // Substituindo Expanded + ListView por Column com ...map()
            Column(
              children: widget.question.options
                  .asMap()
                  .entries
                  .map((entry) {
                int i = entry.key;
                String option = entry.value;
                return GestureDetector(
                  onTap: () => widget.onOptionSelected(i),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: widget.selectedAnswer == i
                          ? Colors.blue.shade100
                          : Colors.white,
                      border: Border.all(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        Radio<int>(
                          value: i,
                          groupValue: widget.selectedAnswer,
                          onChanged: widget.onOptionSelected,
                        ),
                        Flexible(
                          child: Text(
                            '${i + 1}. $option',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }


}
