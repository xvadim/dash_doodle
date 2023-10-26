import 'package:flutter/material.dart';

import '../dash_doodle_game.dart';

class ScoreIndicator extends StatelessWidget {
  const ScoreIndicator(this.game, {super.key});

  final DashDoodleGame game;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: game.gameManager.score,
      builder: (context, value, child) => Text(
        'Score: $value',
        style: Theme.of(context).textTheme.displaySmall!,
      ),
    );
  }
}
