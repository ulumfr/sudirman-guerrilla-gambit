import 'dart:async';
import 'package:flame/components.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/sudirman_game_controller.dart';

enum PlayerState { idle, walk }

enum PlayerDirection { left, right, none }

class PlayerController extends SpriteAnimationGroupComponent
    with HasGameRef<SudirmanGameController> {
  PlayerController({
    position,
  }) : super(position: position);

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation walkAnimation;

  final double stepTime = 0.1;

  PlayerDirection playerDirection = PlayerDirection.none;
  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();
  bool isFacingRight = true;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerMovement(dt);
    super.update(dt);
  }

  void _loadAllAnimations() {
    idleAnimation = _spriteAnimation('idle', 6);
    walkAnimation = _spriteAnimation('walk', 10);

    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.walk: walkAnimation,
    };

    current = PlayerState.idle;
  }

  void _updatePlayerMovement(double dt) {
    double dirX = 0.0;
    switch (playerDirection) {
      case PlayerDirection.left:
        if (isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = false;
        }
        current = PlayerState.walk;
        dirX -= moveSpeed;
        break;
      case PlayerDirection.right:
        if (!isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = true;
        }
        current = PlayerState.walk;
        dirX += moveSpeed;
        break;
      case PlayerDirection.none:
        current = PlayerState.idle;
        break;
      default:
    }
    velocity = Vector2(dirX, 0.0);
    position += velocity * dt;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('characters/arya/$state.png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2(48, 48),
      ),
    );
  }
}
