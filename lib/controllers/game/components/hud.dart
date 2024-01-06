import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/audio_manager.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/sudirman_game_controller.dart';
import 'package:sudirman_guerrilla_gambit/views/game/game_over_game.dart';
import 'package:sudirman_guerrilla_gambit/views/game/pause_menu_game.dart';

class Hud extends Component with HasGameRef<SudirmanGameController> {
  PositionType? positionType;
  late final TextComponent collectComponent;
  late final TextComponent healthComponent;

  Hud({super.children, super.priority}) {
    positionType = PositionType.viewport;
  }

  @override
  FutureOr<void> onLoad() {
    collectComponent = TextComponent(
      text: 'Collect: 0',
      position: Vector2(80, 10),
    );
    add(collectComponent);

    healthComponent = TextComponent(
      text: 'x5',
      position: Vector2(700, 10),
    );
    add(healthComponent);

    gameRef.playerData.collect.addListener(onCollectChange);

    final pauseButton = SpriteButtonComponent(
      onPressed: () {
        AudioManager.pauseBgm();
        gameRef.pauseEngine();
        gameRef.overlays.add(PauseMenuGame.id);
      },
      button: Sprite(
        gameRef.images.fromCache('hud/pause.png'),
      ),
      size: Vector2.all(32),
      position: Vector2(gameRef.size.x / 2, 10),
      anchor: Anchor.topCenter,
    );
    add(pauseButton);

    final healthIndicator = SpriteComponent.fromImage(
      gameRef.images.fromCache('hud/health.png'),
      size: Vector2.all(40),
      position: Vector2(
        healthComponent.position.x - healthComponent.size.x - 10,
        5,
      ),
    );
    add(healthIndicator);

    gameRef.playerData.health.addListener(onHealthChange);

    return super.onLoad();
  }

  void onCollectChange() {
    collectComponent.text = 'Collect: ${gameRef.playerData.collect.value}';
  }

  void onHealthChange() {
    healthComponent.text = 'x${gameRef.playerData.health.value}';

    if (gameRef.playerData.health.value == 0) {
      AudioManager.stopBgm();
      gameRef.pauseEngine();
      gameRef.overlays.add(GameOverGame.id);
    }
  }
}
