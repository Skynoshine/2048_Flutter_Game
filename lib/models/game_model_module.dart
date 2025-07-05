import 'package:game/main.dart';
import 'package:game/models/game_model.dart';
import 'package:game/module/module_factory.dart';

class GameModelModule implements Module {
  @override
  void register() {
    di.registerFactory(() => GameModel());
  }
}