import 'dart:ui';

import 'package:flame/components.dart' hide World;
import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'managers/game_manager.dart';
import 'managers/level_manager.dart';
import 'managers/object_manager.dart';
import 'sprites/player.dart';
import 'widgets/game_home_widget.dart';
import 'world.dart';

class DashDoodleGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  final GameManager gameManager = GameManager();
  final LevelManager levelManager = LevelManager();
  final _world = World();

  late ObjectManager objectManager;
  late Player player;

  int screenBufferSpace = 300;

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    await add(_world);
    await add(FpsTextComponent());

    await add(gameManager);

    await add(levelManager);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (gameManager.isGameOver) {
      return;
    }

    if (gameManager.isMenu) {
      overlays.add(keyMenuOverlay);
      return;
    }

    if (gameManager.isPlaying) {
      _checkLevelUp();

      final Rect worldBounds = Rect.fromLTRB(
        0,
        camera.position.y - screenBufferSpace,
        camera.gameSize.x,
        camera.position.y + _world.size.y,
      );
      camera.worldBounds = worldBounds;

      if (player.isMovingDown) {
        camera.worldBounds = worldBounds;
      }

      final isInTopHalfOfScreen = player.position.y <= (_world.size.y / 2);
      if (!player.isMovingDown && isInTopHalfOfScreen) {
        camera.followComponent(player);
      }

      if (player.position.y >
          camera.position.y +
              _world.size.y +
              player.size.y +
              screenBufferSpace) {
        onLose();
      }
    }
  }

  void startGame() {
    _prepareGame();

    gameManager.state = GameState.playing;
    overlays.remove(keyMenuOverlay);
  }

  void onLose() {
    gameManager.state = GameState.gameOver;
    player.removeFromParent();
    overlays.add(keyGameOverOverlay);
  }

  void _prepareGame() {
    gameManager.reset();

    player = Player();
    add(player);
    player.reset();

    levelManager.reset();

    camera.worldBounds = Rect.fromLTRB(
      0,
      -_world.size.y, // top of screen is 0, so negative is already off screen
      camera.gameSize.x,
      _world.size.y +
          screenBufferSpace, // makes sure bottom bound of game is below bottom of screen
    );

    camera.followComponent(player);

    player.resetPosition();

    objectManager = ObjectManager();
    add(objectManager);
  }

  void _checkLevelUp() {
    if (levelManager.shouldLevelUp(gameManager.score)) {
      levelManager.increaseLevel();

      objectManager.configure(levelManager.level, levelManager.difficulty);

      player.setJumpSpeed(levelManager.jumpSpeed);
    }
  }
}
