import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

import '../dash_doodle_game.dart';

enum GameState { menu, playing, gameOver }

class GameManager extends Component with HasGameRef<DashDoodleGame> {
  bool get isMenu => state == GameState.menu;
  bool get isPlaying => state == GameState.playing;
  bool get isGameOver => state == GameState.gameOver;

  GameState state = GameState.menu;

  ValueNotifier<int> score = ValueNotifier(0);

  void reset() {
    score.value = 0;
    state = GameState.menu;
  }

  void increaseScore() {
    score.value++;
  }
}
