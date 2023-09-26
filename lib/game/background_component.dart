import 'package:flame/components.dart';

import 'dash_doodle_game.dart';

class BackgroundComponent extends SpriteComponent
    with HasGameRef<DashDoodleGame> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    print('LOAD BACKGROUND!!');
    sprite = await gameRef.loadSprite("04_Background_Big_Stars.png");
    size = gameRef.size;
  }
}
