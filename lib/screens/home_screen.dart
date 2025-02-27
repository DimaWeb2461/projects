import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_ce/hive.dart';

import '../core/entities/todo_entity.dart';
import '../core/service/storage_service.dart';
import '../widget/todo_card_widget.dart';
import 'create_todo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<TodoEntity> todos = [
    TodoEntity(
      id: 10,
      title: "Title",
      description: "Lorem",
      dateTime: DateTime.now(),
      isCompleted: false,
    ),
    TodoEntity(
      id: 10,
      title: "Title",
      description: "Lorem",
      dateTime: DateTime.now(),
      isCompleted: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HELLO TODO !"),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final entity = todos[index];
            return TodoCardWidget(entity: entity);
          },
        ),
      ),



      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateTodoScreen(
                onSave: (TodoEntity entity) {
                  todos.add(entity);
                  setState(() {});
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
