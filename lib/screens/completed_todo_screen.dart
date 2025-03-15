import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../cubits/todo_cubit/todo_cubit.dart';
import '../widget/todo_card_widget.dart';

class CompletedTodosScreen extends StatefulWidget {
  const CompletedTodosScreen({super.key});

  @override
  State<CompletedTodosScreen> createState() => _CompletedTodosScreenState();
}

class _CompletedTodosScreenState extends State<CompletedTodosScreen> {
  @override
  void initState() {
    loadTodo();
    super.initState();
  }

  loadTodo() {
    if (mounted) {
      Future.delayed(
        Duration.zero,
            () {
          context.read<TodoCubit>().loadTodo(
            isCompleted: true,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Completed Todos"),
        leading: IconButton(
          onPressed: () {
            context.read<TodoCubit>().loadTodo(
              isCompleted: false,
            );
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.chevron_left),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<TodoCubit, TodoState>(builder: (context, state) {
          if (state is TodoLoaded){
            return state.todos.isEmpty
                ? Center(child: Text('Empty...'))
                : ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final entity = state.todos[index];
                return Dismissible(
                  key: ValueKey(entity.id),
                  direction: DismissDirection.horizontal,
                  onDismissed: (direction) {
                    context
                        .read<TodoCubit>()
                        .deleteTodo(id: entity.id);
                  },
                  background: Container(
                    width: 1.sw,
                    height: 30,
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        "DELETED!",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  child: TodoCardWidget(
                    entity: entity,
                    onDelete: () {
                      context
                          .read<TodoCubit>()
                          .deleteTodo(id: entity.id);
                    },
                    onComplete: (todo) {
                      context
                          .read<TodoCubit>()
                          .saveTodoAndRemoveFromList(todo: todo);
                    },
                    onTap: () {},
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator(),);

        }),
      ),
    );
  }
}