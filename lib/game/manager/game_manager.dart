import 'package:flame/components.dart';

import '../dash_doodle_game.dart';

enum GameState { menu, playing, gameOver }

class GameManager extends Component with HasGameRef<DashDoodleGame> {
  bool get isMenu => state == GameState.menu;

  GameState state = GameState.menu;
}
