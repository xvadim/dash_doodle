import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../dash_doodle_game.dart';
import 'game_over_overlay.dart';
import 'game_overlay.dart';
import 'main_menu_overlay.dart';

const keyMenuOverlay = 'mainMenuOverlay';
const keyGameOverOverlay = 'gameOverOverlay';
const keyGameOverlay = 'gameOverlay';

class GameHomeWidget extends StatelessWidget {
  const GameHomeWidget({super.key, required this.game});

  final DashDoodleGame game;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 800,
            minWidth: 550,
          ),
          child: GameWidget(
            game: game,
            overlayBuilderMap: <String,
                Widget Function(BuildContext, DashDoodleGame)>{
              keyMenuOverlay: (context, game) => MainMenuOverlay(game),
              keyGameOverOverlay: (context, game) => GameOverOverlay(game),
              keyGameOverlay: (context, game) => GameOverlay(game),
            },
          ),
        ),
      ),
    );
  }
}
