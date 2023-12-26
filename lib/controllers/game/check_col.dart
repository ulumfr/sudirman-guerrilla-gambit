bool checkCollision(player, block) {
  final hitbox = player.hitbox;
  // final playerX = player.position.x;
  final playerX = player.position.x + hitbox.offsetX;
  // final playerY = player.position.y;
  final playerY = player.position.y + hitbox.offsetY;
  // final playerW = player.width;
  final playerW = hitbox.width;
  // final playerH = player.height;
  final playerH = hitbox.height;

  final blockX = block.x;
  final blockY = block.y;
  final blockW = block.width;
  final blockH = block.height;

  // final fixedX = player.scale.x < 0 ? playerX - playerW : playerX;
  final fixedX =
      player.scale.x < 0 ? playerX - (hitbox.offsetX * 2) - playerW : playerX;
  // final fixedY = block.isplatform ? playerY + playerH : playerY;
  final fixedY = block.isplatform ? playerY + playerH : playerY;

  return (fixedY < blockY + blockH &&
      playerY + playerH > blockY &&
      fixedX < blockX + blockW &&
      fixedX + playerW > blockX);
}
