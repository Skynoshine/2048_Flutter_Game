import 'package:game/controllers/game_controller_module.dart';
import 'package:game/controllers/ranking_controller_module.dart';
import 'package:game/models/game_model_module.dart';
import 'package:game/module/module_factory.dart';
import 'package:game/services/local_cache_module.dart';

class ModuleService {
  factory ModuleService() => _singleton;
  static final ModuleService _singleton = ModuleService._internal();
  ModuleService._internal();

  static ModuleService get of => ModuleService();

  final List<Module> _modules = [
    LocalCacheModule(),
    GameControllerModule(),
    GameModelModule(),
    RankingControllerModule()
  ];

  Future<void> initialize() async {
    for (final module in _modules) {
      module.register();
    }
  }
}
