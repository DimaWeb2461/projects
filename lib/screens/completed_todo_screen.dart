import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/todo_controller.dart';
import '../providers/todo_controller.dart';
import '../widget/todo_card_widget.dart';

class CompletedTodosScreen extends StatelessWidget {
  const CompletedTodosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoController>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Completed todo!")),
      body: SafeArea(
        child: provider.isLoading
            ? Center(child: CupertinoActivityIndicator())
            : provider.todos.isEmpty
            ? Center(child: Text('Empty...'))
            : ListView.builder(
          itemCount: provider.todos.length,
          itemBuilder: (context, index) {
            final entity = provider.todos[index];
            return Dismissible(
              key: ValueKey(entity.id),
              direction: DismissDirection.horizontal,
              onDismissed: (direction) {
                provider.deleteTodo(entity.id);
              },
              background: Container(
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
                onDelete: () => provider.deleteTodo(entity.id),
                onComplete: () {},
                onTap: () {},
              ),
            );
          },
        ),
      ),
    );
  }
}
