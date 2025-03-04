/*
* 1. Create
* 2. Update
* 3. Delete
* 4. Read */

import 'dart:developer';

import '../entities/todo_entity.dart';
import '../service/storage_service.dart';

class TodoRepository {
  final StorageService _storageService = StorageService();
  static const _boxName = 'todos';

  Future<void> createTodo(TodoEntity todo) async {
    await _storageService.saveWithId(
      value: todo.toJson(),
      boxName: _boxName,
    );
  }

  Future<void> deleteTodo(int id) async {
    await _storageService.delete(id.toString(), boxName: _boxName);
  }

  Future<List<TodoEntity>> loadTodos() async {
    final data = await _storageService.getAll(boxName: _boxName);

    log(data.toString());
    final List<TodoEntity> listTodo = data
        .map(
          (json) => TodoEntity.fromJson(
            Map<String, dynamic>.from(json),
          ),
        )
        .toList();
    return listTodo;
  }
}
