import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/collision_block.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/player_controller.dart';

class MapController extends World {
  MapController({required this.player});
  
  late TiledComponent map;
  final PlayerController player;
  List<CollisionBlock> collisionBlocks = [];

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

    final collisionslayer = map.tileMap.getLayer<ObjectGroup>('Collisions');

    if(collisionslayer != null){
      for(final collision in collisionslayer.objects){
        switch(collision.class_){
          case 'Platform':
            final platform = CollisionBlock(
                position: Vector2(collision.x, collision.y),
                size: Vector2(collision.width, collision.height),
                isplatform: true
            );
            collisionBlocks.add(platform);
            add(platform);
            break;
          default:
            final block = CollisionBlock(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
            );
            collisionBlocks.add(block);
            add(block);
            break;
        }
      }
    }
    player.collisionBlocks = collisionBlocks;
    return super.onLoad();
  }
}
