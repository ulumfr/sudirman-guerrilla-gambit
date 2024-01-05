import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:sudirman_guerrilla_gambit/constants.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/sudirman_game_controller.dart';
import 'package:sudirman_guerrilla_gambit/models/custom_hitbox.dart';

class Collectible extends SpriteAnimationComponent
    with HasGameRef<SudirmanGameController>, CollisionCallbacks {
  final String item;
  Collectible({
    this.item = 'Duid',
    position,
    size,
  }) : super(
          position: position,
          size: size,
        );

  final double stepTime = 0.2;
  final hitbox = CustomHitbox(offsetX: 10, offsetY: 10, width: 12, height: 12);

  @override
  FutureOr<void> onLoad() {
    debugMode = Global.debugMode;
    priority = -1;
    add(
      RectangleHitbox(
        position: Vector2(hitbox.offsetX, hitbox.offsetY),
        size: Vector2(hitbox.width, hitbox.height),
        collisionType: CollisionType.passive,
      ),
    );
    animation = _spriteAnimation(item, 5);
    return super.onLoad();
  }

  SpriteAnimation _spriteAnimation(String item, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('collectible/$item/$item-sheet.png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2.all(64),
      ),
    );
  }

  void collidingwithplayer() {
    removeFromParent();
  }
}
