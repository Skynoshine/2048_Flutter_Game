import 'package:game/controllers/ranking_controller.dart';
import 'package:game/main.dart';
import 'package:game/module/module_factory.dart';

class RankingControllerModule implements Module {
  @override
  void register() {
    di.registerFactory(() => RankingController());
  }
}
