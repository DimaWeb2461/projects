import 'package:hive_ce/hive.dart';

class StorageService {
  LazyBox _openBox() {
    final box = Hive.lazyBox("application");
    return box;
  }

  Future<void> add(dynamic value) async {
    final box = _openBox();
    await box.add(value);
  }

 Future<void> save(String key, {required dynamic value}) async {
    final box = _openBox();
    await box.put(key, value);
  }
  Future<dynamic> get(String key) async {
    final box = _openBox();
    final response = await box.get(key);
    return response;
  }
  Future<void> delete(String key) async {
    final box = _openBox();
    await box.delete(key);
  }
}

