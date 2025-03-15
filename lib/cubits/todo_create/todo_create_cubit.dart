import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../core/entities/todo_entity.dart';
import '../../core/repositories/todo_repository.dart';

part 'todo_create_state.dart';

class TodoCreateCubit extends Cubit<TodoCreateState> {
  final TodoRepository todoRepository;
  TodoCreateCubit(this.todoRepository) : super(TodoCreateInitial());


  saveTodo({required TodoEntity entity}) async {
    await _try(action: () async {
      emit(TodoCreateLoading());
      await todoRepository.createTodo(entity);
      emit(TodoCreateSuccess());
    });
  }

  _try({required Function() action}) {
    try {
      action.call();
    } catch (error) {
      emit(TodoCreateError("Error: ${error.toString()}"));
    }
  }
}
