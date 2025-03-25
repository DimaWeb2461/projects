/*
* 1. Create
* 2. Update
* 3. Delete
* 4. Read */

import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../api/errors.dart';
import '../api/firebase_client.dart';
import '../api/firebase_constants.dart';
import '../entities/todo_entity.dart';
import '../service/storage_service.dart';
import '../utils/action.dart';

enum TodoSearchBy {
  title,
  description,
  ;

  String get name {
    switch (this) {
      case TodoSearchBy.title:
        return "Title";
      case TodoSearchBy.description:
        return "Description";
    }
  }
}

class TodoRepository {
  final StorageService _storageService;
  final FirebaseClient _client;
  TodoRepository(this._storageService, this._client);
  static const _boxName = 'todos';

  Future<Either<AppError, void>> createTodo(TodoEntity todo) {
    return action(
      task: () async {
        await _client.postWithId(
          collection: FirebaseConstants.kTodos,
          data: todo.toJson(),
        );
      },
    );

    // await _storageService.saveWithId(
    //   value: todo.toJson(),
    //   boxName: _boxName,
    // );
  }

  Future<void> deleteTodo(int id) async {
    await _client.delete(
      collection: FirebaseConstants.kTodos,
      id: id.toString(),
    );
    // await _storageService.delete(id.toString(), boxName: _boxName);
  }

  Future<List<TodoEntity>> loadTodos(
      {bool? isCompleted,
      String? query,
      TodoSearchBy? searchBy = TodoSearchBy.title}) async {
    // final data = await _storageService.getAll(boxName: _boxName);
    final filters = [
      FirebaseFilter(
        field: "isCompleted",
        type: FirebaseApiFilterType.isEqualsTo,
        value: isCompleted,
      ),
    ];

    if (query != null && query.isNotEmpty) {
      switch (searchBy) {
        case TodoSearchBy.title:
          filters.add(
            FirebaseFilter(
              field: "title",
              type: FirebaseApiFilterType.isEqualsTo,
              value: query,
            ),
          );
        case TodoSearchBy.description:
          filters.add(
            FirebaseFilter(
              field: "description",
              type: FirebaseApiFilterType.isEqualsTo,
              value: query,
            ),
          );
        case null:
          throw UnimplementedError();
      }
    }

    final data = await _client.get(
        collection: FirebaseConstants.kTodos, filters: filters);

    log(data.toString());
    final List<TodoEntity> listTodo = List<TodoEntity>.from(data.map(
      (json) {
        return TodoEntity.fromJson(
          Map<String, dynamic>.from(json),
        );
      },
    )).toList();

    return listTodo;
  }
}
