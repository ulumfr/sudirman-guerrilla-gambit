import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/sudirman_game_controller.dart';
import 'package:sudirman_guerrilla_gambit/views/game/pause_menu_game.dart';

class Hud extends Component with HasGameRef<SudirmanGameController> {
  PositionType? positionType;

  late final TextComponent collectComponent;
  Hud({super.children, super.priority}) {
    positionType = PositionType.viewport;
  }

  @override
  FutureOr<void> onLoad() {
    collectComponent = TextComponent(
      text: 'Collect: 0',
      position: Vector2(80, 10),
      // anchor: Anchor.topLeft,
    );
    add(collectComponent);

    gameRef.playerData.collect.addListener(onCollectChange);

    final pauseButton = SpriteButtonComponent(
      onPressed: () {
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
    
    return super.onLoad();
  }

  void onCollectChange() {
    collectComponent.text = 'Collect: ${gameRef.playerData.collect.value}';
  }
}
