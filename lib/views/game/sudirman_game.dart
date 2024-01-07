import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/sudirman_game_controller.dart';
import 'package:sudirman_guerrilla_gambit/views/game/game_over_game.dart';
import 'package:sudirman_guerrilla_gambit/views/game/pause_menu_game.dart';

class SudirmanGame extends StatelessWidget {
  SudirmanGame({Key? key}) : super(key: key);

  final SudirmanGameController game = SudirmanGameController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget<SudirmanGameController>(
        game: game,
        overlayBuilderMap: {
          PauseMenuGame.id: (context, game) => PauseMenuGame(gameRef: game),
          GameOverGame.id: (context, game) => GameOverGame(gameRef: game),
        },
      ),
    );
  }
}
