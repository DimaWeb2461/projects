
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../core/api/errors.dart';
import '../../core/api/firebase_client.dart';
import '../../core/entities/todo_entity.dart';
import '../../core/repositories/todo_repository.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository todoRepository;
  TodoCubit(this.todoRepository) : super(TodoInitial());
  List<TodoEntity> _todos = [];
  loadTodo({
    TodoSearchBy todoSearchBy = TodoSearchBy.title,
    String query = '',
    bool? isCompleted,
  }) async {
    await _try(action: () async {
      emit(TodoLoading());
      await Future.delayed(Duration(seconds: 1));
      try {
        _todos = await todoRepository.loadTodos(
          isCompleted: isCompleted,
          query: query,
          searchBy: todoSearchBy,
        );
        emit(TodoLoaded(_todos));
      } catch (error) {
        emit(TodoError("Error ${error.toString()}"));
      }
    });

  }

  deleteTodo({required int id}) async {
    await _try(action: () async {
      await todoRepository.deleteTodo(id);
      _todos.removeWhere(
            (element) => element.id == id,
      );
      emit(TodoLoaded(_todos));
    });
  }


  saveTodoAndRemoveFromList({required TodoEntity todo}) async {
    await _try(action: () async {
      await todoRepository.createTodo(todo);
      final index = _findTodoAndIndex(todo);

      _todos.removeAt(index);
      emit(TodoLoaded(_todos));
    });
  }

  int _findTodoAndIndex(TodoEntity entity) {
    return _todos.indexWhere((element) => element.id == entity.id);
  }

  _try({required Function() action}) {
    try {
      action.call();
    } on ExceptionWithMessage catch (error) {
      emit(TodoError("Error: ${error.message}"));
    } catch (error) {
      emit(TodoError("Error: ${error.toString()}"));
    }
  }
}
