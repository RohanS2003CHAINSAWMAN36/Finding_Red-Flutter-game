import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/painting.dart';

class BackgroundTile extends ParallaxComponent with HasGameRef {
  // extra added with HasGameRef to use gameRef
  final String color;
  BackgroundTile({this.color = 'Gray', position}) : super(position: position);
  final double scrollSpeed = 40;

  @override
  FutureOr<void> onLoad() async {
    priority = -1;
    size = Vector2.all(64.6);
    parallax = await gameRef.loadParallax(
      [ParallaxImageData('Background/$color.png')],
      baseVelocity: Vector2(0, -scrollSpeed),
      repeat: ImageRepeat.repeat,
      fill: LayerFill.none,
    );

    return super.onLoad();
  }
}
