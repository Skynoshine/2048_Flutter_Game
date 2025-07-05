import 'package:game/main.dart';
import 'package:game/module/module_factory.dart';
import 'package:game/services/local_cache.dart';

class LocalCacheModule implements Module {
  @override
  void register() {
    di.registerFactory(() => LocalCache());
  }
}
