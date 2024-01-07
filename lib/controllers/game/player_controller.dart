import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
// import 'package:flame_audio/flame_audio.dart';
import 'package:sudirman_guerrilla_gambit/constants.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/audio_manager.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/check_col.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/collectible_controller.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/collision_block.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/sudirman_game_controller.dart';
import 'package:sudirman_guerrilla_gambit/models/custom_hitbox.dart';

enum PlayerState { idle, walk }

class PlayerController extends SpriteAnimationGroupComponent
    with HasGameRef<SudirmanGameController>, CollisionCallbacks {
  PlayerController({
    position,
  }) : super(position: position);

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation walkAnimation;

  final double stepTime = 0.1;
  final double _gravity = 9.8;
  final double _jumpForce = 280;
  final double _terminalVelocity = 300;

  Vector2 spawnPos = Vector2(0, 0);
  Vector2 velocity = Vector2.zero();
  double horizontalMove = 0;
  double moveSpeed = 100;

  bool isOnGround = false;
  bool hasJump = false;
  bool isJumping = false;

  List<CollisionBlock> collisionBlocks = [];

  final hitbox = CustomHitbox(
    offsetX: 15,
    offsetY: 4,
    width: 20,
    height: 40,
  );

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();

    spawnPos = Vector2(position.x, position.y);

    add(RectangleHitbox(
      position: Vector2(hitbox.offsetX, hitbox.offsetY),
      size: Vector2(hitbox.width, hitbox.height),
    ));

    debugMode = Global.debugMode;
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

  void _updatePlayerMovement(double dt) {
    if (hasJump && isOnGround) {
      _playerJump(dt);
    }
    velocity.x = horizontalMove * moveSpeed;
    position.x += velocity.x * dt;
  }

  void _playerJump(double dt) {
    AudioManager.playSfx('jump.wav', 30.0);
    velocity.y = -_jumpForce;
    position.y += velocity.y * dt;
    isOnGround = false;
    hasJump = false;
    isJumping = true;
  }

  void _checkHCollision() {
    for (final block in collisionBlocks) {
      if (!block.isplatform) {
        if (checkCollision(this, block)) {
          if (velocity.x > 0) {
            velocity.x = 0;
            position.x = block.x - hitbox.offsetX - hitbox.width;
            break;
          }
          if (velocity.x < 0) {
            velocity.x = 0;
            position.x = block.x + block.width + hitbox.width + hitbox.offsetX;
            break;
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

  void _checkVCollision() {
    for (final block in collisionBlocks) {
      if (block.isplatform) {
        if (checkCollision(this, block)) {
          if (velocity.y > 0) {
            velocity.y = 0;
            position.y = block.y - hitbox.height - hitbox.offsetY;
            isOnGround = true;
            break;
          }
        }
      } else if (block.isVoid) {
        if (checkCollision(this, block)) {
          if (velocity.y > 0) {
            AudioManager.playSfx('hit.wav', 30.0);
            velocity.y = 0;
            velocity.x = 0;
            scale.x = 1;
            position = spawnPos;
            if (gameRef.playerData.health.value > 0) {
              gameRef.playerData.health.value -= 1;
            }
            break;
          }
        }
      } else {
        if (checkCollision(this, block)) {
          if (velocity.y > 0) {
            velocity.y = 0;
            position.y = block.y - hitbox.height - hitbox.offsetY;
            isOnGround = true;

            if (isJumping) {
              AudioManager.playSfx('landing.wav', 30.0);
              isJumping = false;
            }
            break;
          }
          if (velocity.y < 0) {
            velocity.y = 0;
            position.y = block.y + block.height - hitbox.offsetY;
          }
        }
      }
    }
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

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Collectible) {
      AudioManager.playSfx('collect.wav', 30.0);
      other.collidingwithplayer();
      gameRef.playerData.collect.value += 1;
    }
    super.onCollision(intersectionPoints, other);
  }
}
