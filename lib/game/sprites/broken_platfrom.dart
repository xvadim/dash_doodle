import 'package:flame/components.dart';

import 'platform.dart';

enum BrokenPlatformState { cracked, broken }

class BrokenPlatform extends Platform<BrokenPlatformState> {
  BrokenPlatform({super.position});

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    sprites = <BrokenPlatformState, Sprite>{
      BrokenPlatformState.cracked:
          await gameRef.loadSprite('platform_cracked_monitor.png'),
      BrokenPlatformState.broken:
          await gameRef.loadSprite('platform_monitor_broken.png'),
    };

    current = BrokenPlatformState.cracked;
    size = Vector2(115, 84);
  }

  void breakPlatform() {
    current = BrokenPlatformState.broken;
  }
}
