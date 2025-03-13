import 'package:bloc/bloc.dart';
import '../../core/entities/todo_entity.dart';
import '../../core/repositories/todo_repository.dart';
import 'todo__state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository todoRepository;

  TodoCubit(this.todoRepository) : super(TodoState.initial());

  Future<void> loadTodo({
    TodoSearchBy todoSearchBy = TodoSearchBy.title,
    String query = '',
    bool? isCompleted,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final todos = await todoRepository.loadTodos(
        isCompleted: isCompleted,
        query: query,
        searchBy: todoSearchBy,
      );
      emit(state.copyWith(todos: todos, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: "Failed to load todos"));
    }
  }

  Future<void> deleteTodo(int id) async {
    final updatedTodos = state.todos.where((todo) => todo.id != id).toList();
    emit(state.copyWith(todos: updatedTodos));
    await todoRepository.deleteTodo(id);
  }

  Future<void> saveTodoAndRemove(TodoEntity todo) async {
    final updatedTodos = state.todos.where((t) => t.id != todo.id).toList();
    emit(state.copyWith(todos: updatedTodos));
    await todoRepository.createTodo(todo);
  }

  Future<void> saveTodo(TodoEntity entity) async {
    final index = state.todos.indexWhere((t) => t.id == entity.id);
    final updatedTodos = List<TodoEntity>.from(state.todos);

    if (index == -1) {
      updatedTodos.add(entity);
    } else {
      updatedTodos[index] = entity;
    }

    emit(state.copyWith(todos: updatedTodos));
    await todoRepository.createTodo(entity);
  }
}
