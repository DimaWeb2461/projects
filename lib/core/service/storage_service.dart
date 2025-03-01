import 'package:hive_ce/hive.dart';

class StorageService {
  Future<Box> _openBox({String? boxName}) {
    final box = Hive.openBox(boxName ?? "application");
    return box;
  }

  Future<void> add(dynamic value, {String? boxName}) async {
    final box = await _openBox();
    await box.add(value);
  }

  Future<void> save(String key, {required dynamic value}) async {
    final box = await _openBox();
    await box.put(key, value);
  }

  Future<dynamic> get(String key) async {
    final box = await _openBox();
    final response = await box.get(key);
    return response;
  }

  Future<List<dynamic>> getAll({String? boxName}) async {
    final box = await _openBox();
    final response = box.values.toList();
    return response;
  }

  Future<void> delete(String key) async {
    final box = await _openBox();
    await box.delete(key);
  }
}