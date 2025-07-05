import 'package:game/controllers/game_controller.dart';
import 'package:game/main.dart';
import 'package:game/module/module_factory.dart';

class GameControllerModule implements Module {
  @override
  void register() {
    di.registerFactory(() => GameController());
  }
}
