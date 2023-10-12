import 'dart:math';

import 'package:flame/components.dart';

import '../dash_doodle_game.dart';
import '../sprites/platform.dart';
import '../utils/num_utils.dart';
import 'level_manager.dart';

class ObjectManager extends Component with HasGameRef<DashDoodleGame> {
  ObjectManager({
    this.minVerticalDistanceToNextPlatform = 200,
    this.maxVerticalDistanceToNextPlatform = 300,
  });

  double minVerticalDistanceToNextPlatform;
  double maxVerticalDistanceToNextPlatform;

  final List<Platform> _platforms = [];
  final Random _rand = Random();

  @override
  void onMount() {
    super.onMount();

    double currentX = (gameRef.size.x - platformWidth) / 2;
    double currentY = gameRef.size.y - tallestPlatformHeight / 2;

    for (int i = 0; i < 9; i++) {
      if (i != 0) {
        currentX = _generateNextX(platformWidth);
        currentY = _generateNextY();
      }
      _platforms.add(_randomPlatform(Vector2(currentX, currentY)));

      add(_platforms[i]);
    }
  }

  @override
  void update(double dt) {
    final topOfLowestPlatform =
        _platforms.first.position.y + tallestPlatformHeight;

    final screenBottom = gameRef.player.position.y +
        (gameRef.size.y / 2) +
        gameRef.screenBufferSpace;

    if (topOfLowestPlatform > screenBottom) {
      var newPlatY = _generateNextY();
      var newPlatX = _generateNextX(platformWidth);
      final nextPlat = _randomPlatform(Vector2(newPlatX, newPlatY));
      add(nextPlat);

      _platforms.add(nextPlat);

      gameRef.gameManager.increaseScore();

      _cleanupLastPlatform();
    }

    super.update(dt);
  }

  void configure(int nextLevel, Difficulty config) {
    minVerticalDistanceToNextPlatform = gameRef.levelManager.minDistance;
    maxVerticalDistanceToNextPlatform = gameRef.levelManager.maxDistance;
  }

  double _generateNextX(double platformWidth) {
    final previousPlatformXRange = Range(
      _platforms.last.position.x,
      _platforms.last.position.x + platformWidth,
    );

    double nextPlatformAnchorX;

    do {
      nextPlatformAnchorX =
          _rand.nextDouble() * (gameRef.size.x - platformWidth);
    } while (previousPlatformXRange.overlaps(
        Range(nextPlatformAnchorX, nextPlatformAnchorX + platformWidth)));

    return nextPlatformAnchorX;
  }

  double _generateNextY() {
    final currentHighestPlatformY =
        _platforms.last.center.y + tallestPlatformHeight;

    final distanceToNextY = minVerticalDistanceToNextPlatform +
        _rand.nextDouble() *
            (maxVerticalDistanceToNextPlatform -
                minVerticalDistanceToNextPlatform);

    return currentHighestPlatformY - distanceToNextY;
  }

  void _cleanupLastPlatform() {
    final lowestPlat = _platforms.removeAt(0);

    lowestPlat.removeFromParent();
  }

  Platform _randomPlatform(Vector2 position) {
    return NormalPlatform(position: position);
  }
}
