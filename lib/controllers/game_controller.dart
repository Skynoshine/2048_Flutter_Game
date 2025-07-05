import 'package:flutter/services.dart';
import 'package:game/main.dart';
import 'package:game/models/direction.dart';
import 'package:game/models/game_model.dart';
import 'package:game/widgets/components/particle_painter.dart';

class GameController {
  List<Particle> particles = [];
  DateTime? lastMoveTime;
  bool isMovingFast = false;

  final GameModel _model = di<GameModel>();

  GameModel get model => _model;
  bool get gameOver => _model.gameOver;

  void move(Direction direction) {
    if (!_model.gameOver) {
      _model.move(direction);
    }
  }

  void newGame() async {
    _model.newGame();
  }

  void setFullScreen(bool value) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  void dispose() {
    _model.dispose();
  }

  void addListener(VoidCallback listener) {
    _model.addListener(listener);
  }

  void removeListener(VoidCallback listener) {
    _model.removeListener(listener);
  }
}
