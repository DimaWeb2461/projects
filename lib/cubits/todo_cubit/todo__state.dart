import '../../core/entities/todo_entity.dart';

class TodoState {
  final List<TodoEntity> todos;
  final bool isLoading;
  final String? errorMessage;

  TodoState({
    required this.todos,
    required this.isLoading,
    this.errorMessage,
  });

  factory TodoState.initial() {
    return TodoState(
      todos: [],
      isLoading: false,
      errorMessage: null,
    );
  }

  TodoState copyWith({
    List<TodoEntity>? todos,
    bool? isLoading,
    String? errorMessage,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get hasError => errorMessage != null;
}

class TodoErrorState extends TodoState {
  final String error;

  TodoErrorState(this.error)
      : super(
    todos: [],
    isLoading: false,
    errorMessage: error,
  );
}
