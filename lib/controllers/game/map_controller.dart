import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/player_controller.dart';

class MapController extends World {
  MapController({required this.player});
  
  late TiledComponent map;
  final PlayerController player;

  @override
  FutureOr<void> onLoad() async {
    map = await TiledComponent.load('Map-01.tmx', Vector2.all(16));
    add(map);

    final spawnPointsLayer = map.tileMap.getLayer<ObjectGroup>('Spawnpoints');

    for (final spawnPoint in spawnPointsLayer!.objects) {
      switch (spawnPoint.class_) {
        case 'Player':
          player.position = Vector2(spawnPoint.x, spawnPoint.y);
          add(player);
          break;
        default:
      }
    }
    return super.onLoad();
  }
}
