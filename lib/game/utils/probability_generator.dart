import 'dart:math';

class ProbabilityGenerator {
  final Random _rand = Random();

  bool generateWithProbability(double percent) {
    final randomInt = _rand.nextInt(100) + 1;

    return randomInt <= percent;
  }
}
