import 'package:dash_doodle/game/background_component.dart';
import 'package:flame/components.dart' hide World;
import 'package:flame/game.dart';

import 'world.dart';

class DashDoodleGame extends FlameGame {
  // final _world = BackgroundComponent();
  final _world = World();
  @override
  Future<void>? onLoad() async {
    super.onLoad();
    print('LOAD GAME');
    await add(_world);
    await add(FpsTextComponent(position: Vector2(100, 50)));
  }

  @override
  void update(double dt) {
    super.update(dt);
    // print('UPDATE SCENE $dt - ${DateTime.now()}');
  }
}
