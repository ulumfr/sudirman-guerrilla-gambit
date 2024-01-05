import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:sudirman_guerrilla_gambit/constants.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/check_col.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/collision_block.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/sudirman_game_controller.dart';
import 'package:sudirman_guerrilla_gambit/models/custom_hitbox.dart';

enum NpcState { idle }

class NpcController extends SpriteAnimationGroupComponent
    with HasGameRef<SudirmanGameController> {
  NpcController({super.position, super.size});

  late final SpriteAnimation idleAnimation;

  static const stepTime = 0.1;
  final double _gravity = 9.8; //9.8
  final double _jumpForce = 260;
  final double _terminalVelocity = 300;
  Vector2 velocity = Vector2.zero();
  List<CollisionBlock> collisionBlocks = [];

  final hitbox = CustomHitbox(offsetX: 15, offsetY: 4, width: 20, height: 40);

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    add(
      RectangleHitbox(
        position: Vector2(hitbox.offsetX, hitbox.offsetY),
        size: Vector2(hitbox.width, hitbox.height),
      ),
    );
    debugMode = Global.debugMode;
    return super.onLoad();
  }

  void _loadAllAnimations() {
    idleAnimation = _spriteAnimation('idle', 8);

    animations = {
      NpcState.idle: idleAnimation,
    };
    current = NpcState.idle;
    flipHorizontallyAroundCenter();
  }

  @override
  void update(double dt) {
    _applyGravity(dt);
    _checkVCollision();
    super.update(dt);
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('characters/friend/$state.png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2(48, 48),
      ),
    );
  }

  void _checkVCollision() {
    for (final block in collisionBlocks) {
      if (checkCollision(this, block)) {
        if (velocity.y > 0) {
          velocity.y = 0;
          position.y = block.y - hitbox.height - hitbox.offsetY;
          break;
        }
        if (velocity.y < 0) {
          velocity.y = 0;
          position.y = block.y + block.height - hitbox.offsetY;
        }
      }
    }
  }

  void _applyGravity(double dt) {
    velocity.y += _gravity;
    velocity.y = velocity.y.clamp(-_jumpForce, _terminalVelocity);
    position.y += velocity.y * dt;
  }
}
