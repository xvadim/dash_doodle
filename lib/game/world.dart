import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

import 'dash_doodle_game.dart';

class World extends ParallaxComponent<DashDoodleGame> {
  @override
  Future<void> onLoad() async {
    parallax = await gameRef.loadParallax(
      [
        ParallaxImageData('06_Background_Solid.png'),
        ParallaxImageData('05_Background_Small_Stars.png'),
        ParallaxImageData('04_Background_Big_Stars.png'),
        ParallaxImageData('02_Background_Orbs.png'),
        ParallaxImageData('03_Background_Block_Shapes.png'),
        ParallaxImageData('01_Background_Squiggles.png'),
      ],
      fill: LayerFill.width,
      repeat: ImageRepeat.repeat,
      baseVelocity: Vector2(0, -5),
      velocityMultiplierDelta: Vector2(0, 1.2),
    );
  }
}
