import 'package:flutter/material.dart';

import '../dash_doodle_game.dart';

class MainMenuOverlay extends StatelessWidget {
  const MainMenuOverlay(this.game, {super.key});

  final DashDoodleGame game;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Doodle Dash',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                game.startGame();
              },
              child: const Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}
