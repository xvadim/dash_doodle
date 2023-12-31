import 'package:flutter/material.dart';

import '../dash_doodle_game.dart';
import 'score_indicator.dart';

class GameOverOverlay extends StatelessWidget {
  const GameOverOverlay(this.game, {super.key});

  final DashDoodleGame game;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Game Over!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 50),
            ScoreIndicator(game),
            // Text('Score: ${game.gameManager.score}'),
          ],
        ),
      ),
    );
  }
}
