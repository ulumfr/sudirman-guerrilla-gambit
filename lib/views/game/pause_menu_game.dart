// import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudirman_guerrilla_gambit/constants.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/sudirman_game_controller.dart';

class PauseMenuGame extends StatelessWidget {
  static const id = 'PauseMenu';
  final SudirmanGameController gameRef;
  const PauseMenuGame({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Global.blackColor.withAlpha(100),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: GestureDetector(
                onTap: () {
                  // FlameAudio.bgm.resume();
                  gameRef.overlays.remove(id);
                  gameRef.resumeEngine();
                },
                child: const Text(
                  'Resume',
                  style: TextStyle(
                    color: Global.whiteColor,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 100,
              child: GestureDetector(
                onTap: () {
                  Get.offAndToNamed('/menu');
                },
                child: const Text(
                  'Exit',
                  style: TextStyle(
                    color: Global.whiteColor,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
