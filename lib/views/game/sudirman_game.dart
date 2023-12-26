import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/sudirman_game_controller.dart';

class SudirmanGame extends StatelessWidget {
  SudirmanGame({Key? key}) : super(key: key);

  final SudirmanGameController game = SudirmanGameController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(game: game),
    );
  }
}
