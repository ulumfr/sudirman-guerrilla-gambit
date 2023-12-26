import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudirman_guerrilla_gambit/constants.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/components/jump_button_controller.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/map_controller.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/npc_controller.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/player_controller.dart';

class SudirmanGameController extends FlameGame with DragCallbacks, HasCollisionDetection{
  @override
  Color backgroundColor() => Global.bgGame;
  PlayerController player = PlayerController();
  NpcController npc = NpcController();
  late final CameraComponent cam;
  late JoystickComponent joystick;

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    final world = MapController(
      player: player, npc: npc,
    );
    final cam = CameraComponent.withFixedResolution(
      world: world,
      width: 600,
      height: 360,
    );

    // TiledComponent map = await TiledComponent.load('Map-01.tmx', Vector2.all(16));

    // _levelBounds = Rectangle.fromPoints(
    //     Vector2(0,0),
    //     Vector2(
    //         map.width.toDouble(),
    //         map.height.toDouble())
    // );

    // cam.viewfinder.anchor = const Anchor(0.1, 0.5);
    cam.viewfinder.anchor = Anchor.topLeft;
    // cam.follow(player);
    // cam.setBounds(_levelBounds);
    addAll([cam..priority = -1, world..priority = -1]);
    addJoyStick();

    FlameAudio.bgm.initialize();
    FlameAudio.audioCache.load("Angkara.wav");
    return super.onLoad();
  }

  @override
  void update(double dt) {
    updateJoystick();
    super.update(dt);
  }

  void addJoyStick() {
    joystick = JoystickComponent(
      priority: 1,
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
        left: 32,
        bottom: 39,
      ),
    );
    add(joystick);
    add(JumpButtonController());
  }

  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        // player.playerDirection = PlayerDirection.left;
        player.horizontalMove = -1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        // player.playerDirection = PlayerDirection.right;
        player.horizontalMove = 1;
        break;
      default:
        // player.playerDirection = PlayerDirection.none;
        player.horizontalMove = 0;
        break;
    }
  }

  void goGame() {
    Get.offAndToNamed('/game');
  }

  void goSetting() {
    Get.toNamed('/setting');
  }
}
