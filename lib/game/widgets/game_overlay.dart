import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../dash_doodle_game.dart';
import 'score_indicator.dart';

class GameOverlay extends StatefulWidget {
  const GameOverlay(this.game, {super.key});

  final DashDoodleGame game;

  @override
  State<GameOverlay> createState() => _GameOverlayState();
}

class _GameOverlayState extends State<GameOverlay> {
  bool _isPaused = false;
  final bool _isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            top: 30,
            left: 30,
            child: ScoreIndicator(widget.game),
          ),
          Positioned(
            top: 30,
            right: 30,
            child: ElevatedButton(
              child: Icon(_isPaused ? Icons.play_arrow : Icons.pause, size: 48),
              onPressed: () {
                widget.game.togglePauseState();
                setState(() => _isPaused = !_isPaused);
              },
            ),
          ),
          if (_isMobile)
            Positioned(
              bottom: MediaQuery.of(context).size.height / 4,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: GestureDetector(
                        onTapDown: (_) => widget.game.player.moveLeft(),
                        onTapUp: (_) => widget.game.player.resetDirection(),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 3.0,
                          shadowColor: Theme.of(context).colorScheme.background,
                          child: const Icon(Icons.arrow_left, size: 64),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: GestureDetector(
                        onTapDown: (_) => widget.game.player.moveRight(),
                        onTapUp: (_) => widget.game.player.resetDirection(),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 3.0,
                          shadowColor: Theme.of(context).colorScheme.background,
                          child: const Icon(Icons.arrow_right, size: 64),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (_isPaused)
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 72.0,
              right: MediaQuery.of(context).size.width / 2 - 72.0,
              child: const Icon(
                Icons.pause_circle,
                size: 144.0,
                color: Colors.black12,
              ),
            ),
        ],
      ),
    );
  }
}
