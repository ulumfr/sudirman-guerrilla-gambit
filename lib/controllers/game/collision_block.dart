import 'package:flame/components.dart';
import 'package:sudirman_guerrilla_gambit/constants.dart';

class CollisionBlock extends PositionComponent{
  bool isplatform;

  CollisionBlock({
    position,
    size,
    this.isplatform = false,
  }) : super(
      position: position,
      size: size
  ) {
    debugMode = Global.debugMode;
  }
}