import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_ce/hive.dart';

import '../core/entities/todo_entity.dart';
import '../core/service/storage_service.dart';
import '../widget/todo_card_widget.dart';
import 'edit_todo_screen.dart';

class CompletedTodosScreen extends StatefulWidget {
  const CompletedTodosScreen({super.key});

  @override
  State<CompletedTodosScreen> createState() => _CompletedTodosScreenState();
}

class _CompletedTodosScreenState extends State<CompletedTodosScreen> {
  final List<TodoEntity> todos = [
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Completed todo !"),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final entity = todos[index];
            return Dismissible(
              key: ValueKey(entity.id),
              direction: DismissDirection.horizontal,
              onDismissed: (direction) {
                todos.remove(entity);
              },
              movementDuration: Duration(seconds: 1),
              resizeDuration: Duration(seconds: 2),
              background: Container(
                width: 1.sw,
                height: 30,
                color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "DELETED !",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              child: TodoCardWidget(
                entity: entity,
                onDelete: () {
                  todos.remove(entity);
                  setState(() {});
                },
                onComplete: () {},
                onTap: () {
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
