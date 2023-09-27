import 'dart:math';

import 'package:flame/components.dart';

import '../dash_doodle_game.dart';

/// The supertype for all Platforms, including Enemies
///
/// [T] should be an enum that is used to Switch between sprites, if necessary
/// Many platforms only need one Sprite, so [T] will be an enum that looks
/// something like: `enum { only }`
abstract class Platform<T> extends SpriteGroupComponent<T>
    with HasGameRef<DashDoodleGame> {
  Platform({
    super.position,
  }) : super(size: Vector2.all(100), priority: 2);

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
  }
}

enum NormalPlatformState { only }

class NormalPlatform extends Platform<NormalPlatformState> {
  NormalPlatform({super.position});

  static final Map<String, Vector2> spriteOptions = {
    'platform_monitor': Vector2(115, 84),
    'platform_phone_center': Vector2(100, 55),
    'platform_terminal': Vector2(110, 83),
    'platform_laptop': Vector2(100, 63),
  };

  @override
  Future<void>? onLoad() async {
    var randSpriteIndex = Random().nextInt(spriteOptions.length);

    String randSprite = spriteOptions.keys.elementAt(randSpriteIndex);
    print('Sprite index $randSpriteIndex Sprite name: $randSprite');
    sprites = {
      NormalPlatformState.only: await gameRef.loadSprite('game/$randSprite.png')
    };

    current = NormalPlatformState.only;

    size = spriteOptions[randSprite]!;
    await super.onLoad();
  }
}