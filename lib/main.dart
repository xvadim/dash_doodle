import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game/dash_doodle_game.dart';
import 'game/widgets/game_home_widget.dart';
import 'game/widgets/main_menu_overlay.dart';

void main() {
  runApp(const GameApp());
}

class GameApp extends StatelessWidget {
  const GameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doodle Dash',
      home: GameHomeWidget(game: DashDoodleGame()),
    );
  }
}
