import 'package:flame/components.dart' hide World;
import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'manager/game_manager.dart';
import 'manager/object_manager.dart';
import 'sprites/player.dart';
import 'widgets/game_home_widget.dart';
import 'world.dart';

class DashDoodleGame extends FlameGame with HasKeyboardHandlerComponents {
  final GameManager gameManager = GameManager();
  final _world = World();

  late ObjectManager objectManager;
  late Player player;

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
  }

  void startGame() {
    _prepareGame();

    gameManager.state = GameState.playing;
    overlays.remove(keyMenuOverlay);
  }

  void _prepareGame() {
    player = Player();
    add(player);
    player.reset();
    player.resetPosition();

    objectManager = ObjectManager();
    add(objectManager);
  }
}
