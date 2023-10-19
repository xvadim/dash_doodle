import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../dash_doodle_game.dart';
import '../utils/probability_generator.dart';

const platformWidth = 115.0;
const tallestPlatformHeight = 100.0;

/// The supertype for all Platforms, including Enemies
///
/// [T] should be an enum that is used to Switch between sprites, if necessary
/// Many platforms only need one Sprite, so [T] will be an enum that looks
/// something like: `enum { only }`
abstract class Platform<T> extends SpriteGroupComponent<T>
    with HasGameRef<DashDoodleGame>, CollisionCallbacks {
  Platform({
    super.position,
  }) : super(size: Vector2.all(platformWidth), priority: 2);

  bool _isMoving = false;
  double _direction = 1;
  final Vector2 _velocity = Vector2.zero();
  final double _speed = 35;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    await add(RectangleHitbox());

    _isMoving = ProbabilityGenerator().generateWithProbability(20);
  }

  @override
  void update(double dt) {
    _move(dt);
    super.update(dt);
  }

  void _move(double dt) {
    if (!_isMoving) return;

    final double gameWidth = gameRef.size.x;

    if (position.x <= 0) {
      _direction = 1;
    } else if (position.x >= gameWidth - size.x) {
      _direction = -1;
    }

    _velocity.x = _direction * _speed;

    position += _velocity * dt;
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
    sprites = {
      NormalPlatformState.only: await gameRef.loadSprite('$randSprite.png')
    };

    current = NormalPlatformState.only;

    size = spriteOptions[randSprite]!;
    await super.onLoad();
  }
}
