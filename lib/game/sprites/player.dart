import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'package:flutter/services.dart';

import '../dash_doodle_game.dart';
import 'broken_platfrom.dart';
import 'platform.dart';
import 'spring_board.dart';

enum PlayerState {
  left,
  right,
  center,
}

class Player extends SpriteGroupComponent<PlayerState>
    with HasGameRef<DashDoodleGame>, KeyboardHandler, CollisionCallbacks {
  Player({
    super.position,
    this.jumpVerticalSpeed = 400,
  }) : super(
          size: Vector2(79, 109),
          anchor: Anchor.center,
          priority: 1,
        ) {
    _dashHorizontalCenter = size.x / 2;
  }

  double jumpVerticalSpeed;
  double jumpHorizontalSpeed = 200;

  int _hAxisInput = 0;
  final int movingLeftInput = -1;
  final int movingRightInput = 1;
  Vector2 _velocity = Vector2.zero();
  late final double _dashHorizontalCenter;
  final double _gravity = 9;

  bool get isMovingDown => _velocity.y > 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await add(CircleHitbox());

    await _loadCharacterSprites();
    current = PlayerState.center;
  }

  @override
  void update(double dt) {
    if (gameRef.gameManager.isMenu || gameRef.gameManager.isGameOver) return;

    _velocity.x = _hAxisInput * jumpHorizontalSpeed;

    if (position.x < _dashHorizontalCenter) {
      position.x = gameRef.size.x - _dashHorizontalCenter;
    }
    if (position.x > gameRef.size.x - _dashHorizontalCenter) {
      position.x = _dashHorizontalCenter;
    }

    _velocity.y += _gravity;

    position += _velocity * dt;

    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      moveLeft();
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      moveRight();
    }

    // if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
    //   jump();
    // }

    return true;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    bool isCollidingVertically =
        (intersectionPoints.first.y - intersectionPoints.last.y).abs() < 5;

    if (isMovingDown && isCollidingVertically) {
      current = PlayerState.center;
      switch (other) {
        case NormalPlatform():
          jump();
          return;
        case SpringBoard():
          jump(specialJumpSpeed: jumpVerticalSpeed * 2);
          return;
        case BrokenPlatform() when other.current == BrokenPlatformState.cracked:
          jump();
          other.breakPlatform();
          return;
      }
    }
  }

  void setJumpSpeed(double newJumpSpeed) {
    jumpVerticalSpeed = newJumpSpeed;
  }

  void jump({double? specialJumpSpeed}) {
    _velocity.y =
        specialJumpSpeed != null ? -specialJumpSpeed : -jumpVerticalSpeed;
  }

  void reset() {
    _velocity = Vector2.zero();
    current = PlayerState.center;
  }

  void resetPosition() {
    position = Vector2(
      (gameRef.size.x - size.x) / 2,
      (gameRef.size.y - size.y) / 2,
    );
  }

  void resetDirection() {
    _hAxisInput = 0;
  }

  Future<void> _loadCharacterSprites() async {
    final left = await gameRef.loadSprite('dash_left.png');
    final right = await gameRef.loadSprite('dash_right.png');
    final center = await gameRef.loadSprite('dash_center.png');

    sprites = <PlayerState, Sprite>{
      PlayerState.left: left,
      PlayerState.right: right,
      PlayerState.center: center,
    };
  }

  void moveLeft() {
    current = PlayerState.left;
    _hAxisInput = movingLeftInput;
  }

  void moveRight() {
    current = PlayerState.right;
    _hAxisInput = movingRightInput;
  }
}
