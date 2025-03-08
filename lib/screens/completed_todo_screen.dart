import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_ce/hive.dart';
import 'package:provider/provider.dart';

import '../controllers/todo_controller.dart';
import '../core/entities/todo_entity.dart';
import '../core/repositories/todo_repository.dart';
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
          context.read<TodoController>().loadTodo(
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
            context.read<TodoController>().loadTodo(
                  isCompleted: false,
                );
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.chevron_left),
        ),
      ),
      body: SafeArea(
        child: Consumer<TodoController>(builder: (context, value, child) {
          return value.isLoading
              ? Center(child: CupertinoActivityIndicator())
              : value.listTodo.isEmpty
                  ? Center(child: Text('Empty...'))
                  : ListView.builder(
                      itemCount: value.listTodo.length,
                      itemBuilder: (context, index) {
                        final entity = value.listTodo[index];
                        return Dismissible(
                          key: ValueKey(entity.id),
                          direction: DismissDirection.horizontal,
                          onDismissed: (direction) {
                            context
                                .read<TodoController>()
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
                                  .read<TodoController>()
                                  .deleteTodo(id: entity.id);
                            },
                            onComplete: () {},
                            onTap: () {},
                          ),
                        );
                      },
                    );
        }),
      ),
    );
  }
}
