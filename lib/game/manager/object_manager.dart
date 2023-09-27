import 'dart:math';

import 'package:flame/components.dart';

import '../dash_doodle_game.dart';

final Random _rand = Random();

class ObjectManager extends Component with HasGameRef<DashDoodleGame> {
  ObjectManager({
    this.minVerticalDistanceToNextPlatform = 200,
    this.maxVerticalDistanceToNextPlatform = 300,
  });

  double minVerticalDistanceToNextPlatform;
  double maxVerticalDistanceToNextPlatform;

  @override
  void onMount() {
    super.onMount();
    print('OBJECT MANAGER ON MOUNT');
  }
}
