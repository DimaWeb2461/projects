/*
* 1. Create
* 2. Update
* 3. Delete
* 4. Read */

import 'dart:developer';

import '../entities/todo_entity.dart';
import '../service/storage_service.dart';
enum TodoSearchBy {
  title,
  description,
  ;
  String get name {
    switch(this) {
      case TodoSearchBy.title:
        return "Title";
      case TodoSearchBy.description:
        return "Description";
    }
  }
}
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

  Future<List<TodoEntity>> loadTodos({bool? isCompleted, String? query,TodoSearchBy? searchBy = TodoSearchBy.title}) async {
    final data = await _storageService.getAll(boxName: _boxName);

    log(data.toString());
    final List<TodoEntity> listTodo = data.map(
      (json) {
        return TodoEntity.fromJson(
          Map<String, dynamic>.from(json),
        );
      },
    ).toList();

    List<TodoEntity> filteredList = listTodo;

    if (isCompleted != null) {
      filteredList = listTodo
          .where((element) => element.isCompleted == isCompleted)
          .toList();
    }

    if (query != null && query.isNotEmpty) {
      switch(searchBy) {
        case TodoSearchBy.title:
          filteredList =
              listTodo.where((element) => element.title.contains(query)).toList();
        case TodoSearchBy.description:
          filteredList =
              listTodo.where((element) => element.description.contains(query)).toList();
        case null:
        // TODO: Handle this case.
          throw UnimplementedError();
      }
    }




    return filteredList;
  }
}
