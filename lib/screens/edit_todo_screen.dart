import 'package:flutter/material.dart';

import '../core/entities/todo_entity.dart';
import '../core/repositories/todo_repository.dart';
import '../widget/date_select_widget.dart';

class EditTodoScreen extends StatefulWidget {
  final TodoEntity? todo;
  final Function() onBack;
  const EditTodoScreen({super.key, this.todo, required this.onBack});

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final TextEditingController controllerTitle = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();
  DateTime? selectedDateTime;

  final TodoRepository todoRepository = TodoRepository();

  TodoEntity todoEntity = TodoEntity.empty();

  @override
  void initState() {
    final todo = widget.todo;
    if (todo != null) {
      todoEntity = todo;
      controllerTitle.text = todo.title;
      controllerDescription.text = todo.description;
      selectedDateTime = todo.dateTime;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo != null ? "Edit todo" : 'Create todo'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DateSelectWidget(
                initialDateTime: selectedDateTime,
                onChanged: (value) {
                  selectedDateTime = value;
                },
              ),
              TextFormField(
                controller: controllerTitle,
              ),
              TextFormField(
                controller: controllerDescription,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async {
          if (controllerTitle.text.isEmpty ||
              controllerDescription.text.isEmpty ||
              selectedDateTime == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please fill all fields')),
            );
            return;
          }

          final TodoEntity editedTodo = todoEntity.copyWith(
            title: controllerTitle.text,
            description: controllerDescription.text,
            dateTime: selectedDateTime,
          );

          try {
            await todoRepository.createTodo(editedTodo);
            widget.onBack.call();
            Navigator.pop(context);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error saving todo: $e')),
            );
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}