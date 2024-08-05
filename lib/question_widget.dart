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
  // ignore: library_private_types_in_public_api
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  late FlickManager flickManager;
  //bool _isInitialized = false;

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
    return Container(
      color: const Color(0xFFF6F6F6),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Text(
              textAlign: TextAlign.center,
              widget.question.questionText,
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Center(
              child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: FlickVideoPlayer(flickManager: flickManager)),
            ),
            const SizedBox(height: 32),
            Center(
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                spacing: 1,
                children:
                    List<Widget>.generate(widget.question.options.length, (i) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          border: Border.all(color: Colors.black, width: 1.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${i + 1}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              widget.question.options[i],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Transform.scale(
                        scale: 1.5,
                        child: Radio<int>(
                          value: i,
                          groupValue: widget.selectedAnswer,
                          onChanged: widget.onOptionSelected,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
