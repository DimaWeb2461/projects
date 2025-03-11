import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_ce/hive.dart';
import 'package:provider/provider.dart';

import '../controllers/todo_controller.dart';
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
  final TextEditingController controllerSearch = TextEditingController();
  TodoSearchBy todoSearchBy = TodoSearchBy.title;
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
                todoSearchBy: todoSearchBy,
                query: controllerSearch.text,
                isCompleted: false,
              );
        },
      );
    }
  }

  deleteTodo(int id) {
    context.read<TodoController>().deleteTodo(id: id);
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
            loadTodo();
          },
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controllerSearch,
                      onChanged: (value) {
                        loadTodo();
                      },
                    ),
                  ),
                  _searchByTodo(),
                ],
              ),
              SizedBox(height: 10),
              Consumer<TodoController>(
                builder: (context, value, child) {
                  return value.isLoading
                      ? Expanded(
                          child: CupertinoActivityIndicator(),
                        )
                      : value.listTodo.isEmpty
                          ? Expanded(child: Text('Empty...'))
                          : Expanded(
                              child: ListView.builder(
                                itemCount: value.listTodo.length,
                                itemBuilder: (context, index) {
                                  final entity = value.listTodo[index];
                                  return Dismissible(
                                    key: ValueKey(entity.id),
                                    direction: DismissDirection.horizontal,
                                    onDismissed: (direction) {
                                      deleteTodo(entity.id);
                                      value.listTodo.remove(entity);
                                    },
                                    movementDuration: Duration(seconds: 1),
                                    resizeDuration: Duration(seconds: 2),
                                    background: Container(
                                      width: 1.sw,
                                      height: 30,
                                      color: Colors.red,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                      onDelete: () => deleteTodo(entity.id),
                                      onComplete: (todo) {
                                        context
                                            .read<TodoController>()
                                            .saveTodoAndRemoveFromList(todo: todo);
                                      },
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditTodoScreen(),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                },
              ),
            ],
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

  _searchByTodo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: TodoSearchBy.values.map(
        (e) {
          return GestureDetector(
            onTap: () {
              setState(() {
                todoSearchBy = e;
              });
              loadTodo();
            },
            child: Text(
              e.name.toString(),
              style: TextStyle(
                color: todoSearchBy == e ? Colors.blue : Colors.black,
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
