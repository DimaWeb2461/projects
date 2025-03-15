part of 'todo_cubit.dart';

@immutable
sealed class TodoState {}

final class TodoInitial extends TodoState {}
final class TodoLoading extends TodoState {}
final class TodoError extends TodoState {
  final String message;

  TodoError(this.message);
}

final class TodoSuccessDeleted extends TodoState {}
final class TodoLoaded extends TodoState {
  final List<TodoEntity> todos;

  TodoLoaded(this.todos);
}
