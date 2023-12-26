import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/sudirman_game_controller.dart';

class JumpButtonController extends SpriteComponent
    with HasGameRef<SudirmanGameController>, TapCallbacks {
  JumpButtonController();

  final margin = 32;
  final btnSize = 64;

  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(game.images.fromCache('hud/jumpbutton.png'));
    position = Vector2(
      game.size.x - margin - btnSize,
      game.size.y - margin - btnSize,
    );
    priority = 10;
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.player.hasJump = true;
    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    game.player.hasJump = false;
    super.onTapUp(event);
  }
}
