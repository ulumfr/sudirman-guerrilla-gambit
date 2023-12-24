import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:sudirman_guerrilla_gambit/constants.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/map_controller.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/player_controller.dart';

class SudirmanGameController extends FlameGame with DragCallbacks {
  @override
  Color backgroundColor() => Global.bgGame;
  PlayerController player = PlayerController();
  late final CameraComponent cam;
  late JoystickComponent joystick;

  @override
  final world = MapController();

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    cam = CameraComponent.withFixedResolution(
      world: world,
      width: 600,
      height: 360,
    );
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, world]);
    addJoyStick();

    return super.onLoad();
  }

  @override
  void update(double dt) {
    updateJoystick();
    super.update(dt);
  }

  void addJoyStick() {
    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('hud/knob.png'),
        ),
      ),
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache('hud/joystick.png'),
        ),
      ),
      
      margin: const EdgeInsets.only(
        left: 20,
        bottom: 32,
      ),
    );
    add(joystick);
  }

  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
        player.playerDirection = PlayerDirection.left;
        break;
      case JoystickDirection.right:
        player.playerDirection = PlayerDirection.right;
        break;
      default:
        break;
    }
  }
}
