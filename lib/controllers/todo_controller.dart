import 'package:flutter/material.dart';
import '../core/entities/todo_entity.dart';
import '../core/repositories/todo_repository.dart';

class TodoController extends ChangeNotifier {
  final TodoRepository _todoRepository = TodoRepository();
  List<TodoEntity> _todos = [];
  bool _isLoading = false;

  List<TodoEntity> get todos => _todos;
  bool get isLoading => _isLoading;

  Future<void> loadTodo({bool isCompleted = false}) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _todos = await _todoRepository.loadTodos(isCompleted: isCompleted);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteTodo(int id) async {
    await _todoRepository.deleteTodo(id);
    _todos.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<void> loadCompletedTodos() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _todos = await _todoRepository.loadTodos(isCompleted: true);
    _isLoading = false;
    notifyListeners();
  }

}
