import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

enum CacheKeys { user, highScores, ranking }

class LocalCache {
  final StoreRef<String, Object?> _store = StoreRef.main();
  Database? _db;

  Future<Database> _getDatabase() async {
    if (_db == null) {
      final appDocDir = await getApplicationDocumentsDirectory();
      await appDocDir.create(recursive: true);
      final path = '${appDocDir.path}/cache.db';
      _db = await databaseFactoryIo.openDatabase(path);
    }
    return _db!;
  }

  Future<void> delete(CacheKeys key) async {
    final db = await _getDatabase();
    var store = StoreRef.main();
    await store.record(key.name).delete(db);
  }

  Future<void> setUserPreference(CacheKeys key, dynamic value) async {
    final db = await _getDatabase();
    await _store.record(key.name).put(db, value);
  }

  Future<T?> getUserPreference<T>(CacheKeys key) async {
    final db = await _getDatabase();
    final result = await _store.record(key.name).get(db);
    return result as T?;
  }
}
