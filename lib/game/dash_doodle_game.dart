import 'package:flame/components.dart' hide World;
import 'package:flame/game.dart';

import 'manager/game_manager.dart';
import 'manager/object_manager.dart';
import 'widgets/game_home_widget.dart';
import 'world.dart';

class DashDoodleGame extends FlameGame {
  GameManager gameManager = GameManager();
  late ObjectManager objectManager; // = ObjectManager();
  final _world = World();

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    await add(_world);
    await add(FpsTextComponent());

    await add(gameManager);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (gameManager.isMenu) {
      overlays.add(keyMenuOverlay);
      return;
    }
    //...
    // print('UPDATE SCENE $dt - ${DateTime.now()}');
  }

  void startGame() {
    print('START GAME!!');
    _prepareGame();
    gameManager.state = GameState.playing;
    overlays.remove(keyMenuOverlay);
  }

  void _prepareGame() {
    objectManager = ObjectManager();

    add(objectManager);
  }
}
