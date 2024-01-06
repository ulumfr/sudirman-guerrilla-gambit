import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/audio_manager.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/collectible_controller.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/collision_block.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/npc_controller.dart';
import 'package:sudirman_guerrilla_gambit/controllers/game/player_controller.dart';

class MapController extends World {
  MapController({required this.player, required this.npc});

  late TiledComponent map;
  final PlayerController player;
  final NpcController npc;
  List<CollisionBlock> collisionBlocks = [];

  @override
  FutureOr<void> onLoad() async {
    AudioManager.playBgm('Angkara.wav', 0.3);
    
    map = await TiledComponent.load('Map-02.tmx', Vector2.all(16));
    await add(map..priority = -1);

    final spawnPointsLayer = map.tileMap.getLayer<ObjectGroup>('Spawnpoints');

    if (spawnPointsLayer != null) {
      for (final spawnPoint in spawnPointsLayer.objects) {
        switch (spawnPoint.class_) {
          case 'Player':
            player.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(player);
            break;
          case 'Soldier':
            npc.position = Vector2(spawnPoint.x, spawnPoint.y);
            // npc.size = Vector2(spawnPoint.width, spawnPoint.height);
            add(npc);
            break;
          case 'Collectibles':
            final item = Collectible(
                item: spawnPoint.name,
                position: Vector2(spawnPoint.x, spawnPoint.y),
                size: Vector2(spawnPoint.width, spawnPoint.height));
            add(item);
            break;
          default:
        }
      }
    }

    final collisionslayer = map.tileMap.getLayer<ObjectGroup>('Collisions');

    if (collisionslayer != null) {
      for (final collision in collisionslayer.objects) {
        switch (collision.class_) {
          case 'Platform':
            final platform = CollisionBlock(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
              isplatform: true,
            );
            collisionBlocks.add(platform);
            add(platform);
            break;
          // case 'Checkpoint':
          //   final checkpoint = CollisionBlock(
          //     position: Vector2(collision.x, collision.y),
          //     size: Vector2(collision.width, collision.height),
          //     isplatform: true,
          //   );
          //   collisionBlocks.add(checkpoint);
          //   add(checkpoint);
          //   break;
          case 'Void':
            final ded = CollisionBlock(
                position: Vector2(collision.x, collision.y),
                size: Vector2(collision.width, collision.height),
                isVoid: true);
            collisionBlocks.add(ded);
            add(ded);
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
    npc.collisionBlocks = collisionBlocks;
    return super.onLoad();
  }
}
