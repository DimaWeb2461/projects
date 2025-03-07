import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/todo_controller.dart';
import '../core/entities/todo_entity.dart';

import '../widget/todo_card_widget.dart';
import 'completed_todo_screen.dart';
import 'edit_todo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoController>(context);

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
            await provider.loadTodo();
          },
          child: Column(
            children: [
              SizedBox(height: 10),
              provider.isLoading
                  ? Center(child: CupertinoActivityIndicator())
                  : provider.todos.isEmpty
                  ? Center(child: Text('Empty...'))
                  : Expanded(
                child: ListView.builder(
                  itemCount: provider.todos.length,
                  itemBuilder: (context, index) {
                    final entity = provider.todos[index];
                    return Dismissible(
                      key: ValueKey(entity.id),
                      direction: DismissDirection.horizontal,
                      onDismissed: (direction) async {
                        await provider.deleteTodo(entity.id);
                      },
                      background: Container(
                        color: Colors.red,
                        child: Center(
                          child: Text(
                            "DELETED !",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      child: TodoCardWidget(
                        entity: entity,
                        onDelete: () async =>
                        await provider.deleteTodo(entity.id),
                        onComplete: () {},
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditTodoScreen(
                                todo: entity,
                                onBack: () async {
                                  await provider.loadTodo();
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
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
              builder: (context) => EditTodoScreen(
                onBack: () async {
                  await provider.loadTodo();
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
