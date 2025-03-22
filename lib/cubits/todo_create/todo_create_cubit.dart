import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../core/api/firebase_client.dart';
import '../../core/entities/todo_entity.dart';
import '../../core/repositories/todo_repository.dart';
import '../todo_cubit/todo_cubit.dart';

part 'todo_create_state.dart';

class TodoCreateCubit extends Cubit<TodoCreateState> {
  final TodoRepository todoRepository;
  TodoCreateCubit(this.todoRepository) : super(TodoCreateInitial());

  saveTodo({required TodoEntity entity}) async {
    emit(TodoCreateLoading());
    final response = await todoRepository.createTodo(entity);
    response.fold((l) {
      emit(TodoCreateError(l.errorMessage));
    }, (r) async {
      emit(TodoCreateSuccess());
      await Future.delayed(Duration(seconds: 2));
    });
  }
}
