part of 'todo_create_cubit.dart';

@immutable
sealed class TodoCreateState {}

final class TodoCreateInitial extends TodoCreateState {}
final class TodoCreateLoading extends TodoCreateState {}
final class TodoCreateError extends TodoCreateState {
  final String message;

  TodoCreateError(this.message);
}
final class TodoCreateSuccess extends TodoCreateState {}

