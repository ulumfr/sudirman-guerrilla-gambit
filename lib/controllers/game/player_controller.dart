import 'dart:async';
import 'package:flame/components.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/check_col.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/collision_block.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/sudirman_game_controller.dart';

enum PlayerState { idle, walk }

// enum PlayerDirection { left, right, none }

class PlayerController extends SpriteAnimationGroupComponent
    with HasGameRef<SudirmanGameController> {
  PlayerController({
    position,
  }) : super(position: position);

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation walkAnimation;

  final double stepTime = 0.1;
  final double _gravity = 50; //9.8
  final double _jumpForce = 460;
  final double _terminalVelocity = 300;
  double horizontalMove = 0;
  bool isOnGround = false;
  bool hasJump = false;

  // PlayerDirection playerDirection = PlayerDirection.none;
  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();
  // bool isFacingRight = true;
  List<CollisionBlock> collisionBlocks = [];

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerState();
    _updatePlayerMovement(dt);
    _checkHCollision();
    _applyGravity(dt);
    _checkVCollision();
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
    // double dirX = 0.0;
    // switch (playerDirection) {
    //   case PlayerDirection.left:
    //     if (isFacingRight) {
    //       flipHorizontallyAroundCenter();
    //       isFacingRight = false;
    //     }
    //     current = PlayerState.walk;
    //     dirX -= moveSpeed;
    //     break;
    //   case PlayerDirection.right:
    //     if (!isFacingRight) {
    //       flipHorizontallyAroundCenter();
    //       isFacingRight = true;
    //     }
    //     current = PlayerState.walk;
    //     dirX += moveSpeed;
    //     break;
    //   case PlayerDirection.none:
    //     current = PlayerState.idle;
    //     break;
    //   default:
    // }
    // velocity = Vector2(dirX, 0.0);
    if (hasJump && isOnGround) {
      _playerJump(dt);
    }
    velocity.x = horizontalMove * moveSpeed;
    position.x += velocity.x * dt;
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

  void _checkHCollision() {
    for (final block in collisionBlocks) {
      if (!block.isplatform) {
        if (checkCollision(this, block)) {
          if (velocity.x > 0) {
            velocity.x = 0;
            position.x = block.x - width;
            break;
          }
          if (velocity.x < 0) {
            velocity.x = 0;
            position.x = block.x + block.width + width;
            break;
          }
        }
      }
    }
  }

  void _checkVCollision() {
    for (final block in collisionBlocks) {
      if (block.isplatform) {
        if (checkCollision(this, block)) {
          if (velocity.y > 0) {
            velocity.y = 0;
            position.y = block.y - width;
            isOnGround = true;
            break;
          }
        }
      } else {
        if (checkCollision(this, block)) {
          if (velocity.y > 0) {
            velocity.y = 0;
            position.y = block.y - width;
            isOnGround = true;
            break;
          }
          if (velocity.y < 0) {
            velocity.y = 0;
            position.y = block.y - block.height;
          }
        }
      }
    }
  }

  void _applyGravity(double dt) {
    velocity.y += _gravity;
    velocity.y = velocity.y.clamp(-_jumpForce, _terminalVelocity);
    position.y += velocity.y * dt;
  }

  void _updatePlayerState() {
    PlayerState playerState = PlayerState.idle;

    if (velocity.x < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    } else if (velocity.x > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }

    if (velocity.x > 0 || velocity.x < 0) {
      playerState = PlayerState.walk;
    }

    current = playerState;
  }

  void _playerJump(double dt) {
    velocity.y = -_jumpForce;
    position.y += velocity.y * dt;
    hasJump = false;
    isOnGround = false;
  }
}
