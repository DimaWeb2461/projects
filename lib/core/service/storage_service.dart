import 'package:hive_ce/hive.dart';

abstract class StorageService {
  Future<void> add(dynamic value, {String? boxName});
  Future<void> save(String key, {required dynamic value, String? boxName});
  Future<void> saveWithId({required dynamic value, String? boxName});
  Future<dynamic> get(String key);
  Future<List<dynamic>> getAll({String? boxName});
  Future<void> delete(String key, {String? boxName});
  Future<void> deleteAll(String? boxName);
}

class HiveStorageServiceImpl extends StorageService {
  // static final StorageServiceImpl _singleton = StorageServiceImpl._internal();
  // factory StorageServiceImpl() {
  //   return _singleton;
  // }
  // StorageService._internal();

  Future<Box> _openBox({String? boxName}) {
    final box = Hive.openBox(boxName ?? "application");
    return box;
  }

  Future<void> add(dynamic value, {String? boxName}) async {
    final box = await _openBox();
    await box.add(value);
  }

  Future<void> save(String key,
      {required dynamic value, String? boxName}) async {
    final box = await _openBox(boxName: boxName);
    await box.put(key, value);
  }

  Future<void> saveWithId({required dynamic value, String? boxName}) async {
    final box = await _openBox(boxName: boxName);
    await box.put(value['id'].toString(), value);
  }

  Future<dynamic> get(String key) async {
    final box = await _openBox();
    final response = await box.get(key);
    return response;
  }

  Future<List<dynamic>> getAll({String? boxName}) async {
    final box = await _openBox(boxName: boxName);
    final response = box.values.toList();
    return response;
  }

  Future<void> delete(String key, {String? boxName}) async {
    final box = await _openBox(boxName: boxName);
    await box.delete(key);
  }

  Future<void> deleteAll(String? boxName) async {
    final box = await _openBox(boxName: boxName);
    await box.deleteFromDisk();
  }
}
