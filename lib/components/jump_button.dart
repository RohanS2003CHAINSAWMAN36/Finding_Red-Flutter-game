import 'dart:async';

import 'package:finding_red/finding_red.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class JumpButton extends SpriteComponent
    with HasGameRef<FindingRed>, TapCallbacks {
  final margin = 32;
  final buttonSize = 64;
  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(game.images.fromCache('HUD/JumpButton.png'));
    position = Vector2(
        game.size.x - margin - buttonSize, game.size.y - margin - buttonSize);
    priority = 10;
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.player.hasJumped = true;
    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    game.player.hasJumped = false;
    super.onTapUp(event);
  }
}
