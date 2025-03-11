import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/todo_controller.dart';
import '../core/entities/todo_entity.dart';
import '../core/repositories/todo_repository.dart';
import '../widget/date_select_widget.dart';

class EditTodoScreen extends StatefulWidget {
  final TodoEntity? todo;
  const EditTodoScreen({super.key, this.todo,});

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final TextEditingController controllerTitle = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();
  DateTime? selectedDateTime;

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
         final TodoEntity editedTodo = todoEntity.copyWith(
           title: controllerTitle.text,
           description: controllerDescription.text,
           dateTime: selectedDateTime,
         );
         context.read<TodoController>().saveTodo(entity: editedTodo);
        Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}