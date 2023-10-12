import 'package:flame/components.dart';

import 'package:flutter/services.dart';

import '../dash_doodle_game.dart';

enum PlayerState {
  left,
  right,
  center,
}

class Player extends SpriteGroupComponent<PlayerState>
    with HasGameRef<DashDoodleGame>, KeyboardHandler {
  Player({
    super.position,
    this.jumpSpeed = 200,
  }) : super(
          size: Vector2(79, 109),
          anchor: Anchor.center,
          priority: 1,
        ) {
    _dashHorizontalCenter = size.x / 2;
  }

  double jumpSpeed;

  int _hAxisInput = 0;
  final int movingLeftInput = -1;
  final int movingRightInput = 1;
  Vector2 _velocity = Vector2.zero();
  late final double _dashHorizontalCenter;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await _loadCharacterSprites();
    current = PlayerState.center;
  }

  @override
  void update(double dt) {
    if (gameRef.gameManager.isMenu || gameRef.gameManager.isGameOver) return;

    _velocity.x = _hAxisInput * jumpSpeed;

    if (position.x < _dashHorizontalCenter) {
      position.x = gameRef.size.x - _dashHorizontalCenter;
    }
    if (position.x > gameRef.size.x - _dashHorizontalCenter) {
      position.x = _dashHorizontalCenter;
    }

    position += _velocity * dt;

    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      _moveLeft();
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      _moveRight();
    }

    return true;
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

  void _moveLeft() {
    current = PlayerState.left;
    _hAxisInput = movingLeftInput;
  }

  void _moveRight() {
    current = PlayerState.right;
    _hAxisInput = movingRightInput;
  }
}
