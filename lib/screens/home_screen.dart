import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_ce/hive.dart';

import '../core/entities/todo_entity.dart';
import '../core/repositories/todo_repository.dart';
import '../core/service/storage_service.dart';
import '../widget/todo_card_widget.dart';
import 'completed_todo_screen.dart';
import 'edit_todo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TodoEntity> todos = [];

  final TodoRepository todoRepository = TodoRepository();
  @override
  void initState() {
    loadTodo();
    super.initState();
  }

  loadTodo() async {
    todos = await todoRepository.loadTodos();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HELLO TODO !"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CompletedTodosScreen(),
                ),
              );
            },
            icon: Icon(Icons.check_box),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await loadTodo();
          },
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTodoScreen(
                          todo: entity,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditTodoScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
