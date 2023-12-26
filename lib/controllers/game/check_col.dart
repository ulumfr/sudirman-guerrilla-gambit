bool checkCollision(player, block) {
  final playerX = player.position.x;
  final playerY = player.position.y;
  final playerW = player.width;
  final playerH = player.height;

  final blockX = block.x;
  final blockY = block.y;
  final blockW = block.width;
  final blockH = block.height;

  final fixedX = player.scale.x < 0 ? playerX - playerW : playerX;
  final fixedY = block.isplatform ? playerY + playerH : playerY;
  
  return (fixedY < blockY + blockH &&
      playerY + playerH > blockY &&
      fixedX < blockX + blockW &&
      fixedX + playerW > blockX);
}
