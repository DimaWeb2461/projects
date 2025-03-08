import 'package:flutter/material.dart';
import '../core/entities/todo_entity.dart';
import '../core/repositories/todo_repository.dart';

class TodoController extends ChangeNotifier {
  final TodoRepository todoRepository = TodoRepository();
  List<TodoEntity> _todos = [];
  bool _isLoading = false;

  List<TodoEntity> get listTodo => _todos;
  bool get isLoading => _isLoading;
  loadTodo({TodoSearchBy todoSearchBy = TodoSearchBy.title, String query = '', bool? isCompleted}) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _todos = await todoRepository.loadTodos(
      isCompleted: isCompleted,
      query: query,
      searchBy: todoSearchBy,
    );
    _isLoading = false;
    notifyListeners();
  }

  deleteTodo({required int id}) async {
    await todoRepository.deleteTodo(id);
    _todos.removeWhere(
      (element) => element.id == id,
    );
    notifyListeners();
  }

  saveTodo({required TodoEntity entity}) async {
    await todoRepository.createTodo(entity);


    final index = _findTodoAndIndex(entity);
    if (index != -1) {
      _todos.add(entity);
    } else {
      _todos[index] = entity;
    }
    notifyListeners();
  }

  int _findTodoAndIndex(TodoEntity entity) {
    return _todos.indexWhere((element) => element.id == entity.id);
  }
}
