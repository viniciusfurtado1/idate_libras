import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:idate_libras/idate_e/question_page_idate_e.dart';
import 'package:video_player/video_player.dart';

class IdateEInstrucoes extends StatefulWidget {
  const IdateEInstrucoes({super.key});

  @override
  State<IdateEInstrucoes> createState() => _IdateTInstrucoesState();
}

class _IdateTInstrucoesState extends State<IdateEInstrucoes> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.asset(
        "assets/videos/idatee/E-0.mp4",
      )
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Defina a cor desejada aqui
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          "IDATE-E/LIBRAS",
          style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //const SizedBox(height: 96),
              const Text(
                "INSTRUÇÕES",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Center(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: FlickVideoPlayer(flickManager: flickManager),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const QuestionPageIdateE()));
        },
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.arrow_forward, color: Colors.white,),
      ),
    );
  }
}
