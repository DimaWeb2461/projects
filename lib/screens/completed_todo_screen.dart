import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubits/todo_cubit/todo__cubit.dart';
import '../cubits/todo_cubit/todo__state.dart';
import '../cubits/todo_cubit/todo_cubit.dart'; // Убедись, что путь правильный
import '../cubits/todo_cubit/todo_state.dart';
import '../core/entities/todo_entity.dart';
import '../widget/todo_card_widget.dart';

class CompletedTodosScreen extends StatefulWidget {
  const CompletedTodosScreen({super.key});

  @override
  State<CompletedTodosScreen> createState() => _CompletedTodosScreenState();
}

class _CompletedTodosScreenState extends State<CompletedTodosScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TodoCubit>().loadTodo(isCompleted: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Completed Todos"),
        leading: IconButton(
          onPressed: () {
            context.read<TodoCubit>().loadTodo(isCompleted: false);
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.chevron_left),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<TodoCubit, TodoState>(
          builder: (context, state) {
            if (state is loadTodo) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (state is loadTodo) {
              if (state.todos.isEmpty) {
                return const Center(child: Text('Empty...'));
              }
              return ListView.builder(
                itemCount: state.todos.length,
                itemBuilder: (context, index) {
                  final entity = state.todos[index];
                  return Dismissible(
                    key: ValueKey(entity.id),
                    direction: DismissDirection.horizontal,
                    onDismissed: (direction) {
                      context.read<TodoCubit>().deleteTodo(entity.id);
                    },
                    background: Container(
                      width: 1.sw,
                      height: 30,
                      color: Colors.red,
                      child: const Center(
                        child: Text(
                          "DELETED!",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    child: TodoCardWidget(
                      entity: entity,
                      onDelete: () {
                        context.read<TodoCubit>().deleteTodo(entity.id);
                      },
                      onComplete: (todo) {
                        context.read<TodoCubit>().saveTodoAndRemove(todo);
                      },
                      onTap: () {},
                    ),
                  );
                },
              );
            } else if (state is TodoErrorState) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
