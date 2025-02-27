import 'package:flutter/material.dart';

import '../core/entities/todo_entity.dart';
import '../widget/date_select_widget.dart';
import '../widget/todo_card_widget.dart';

class CreateTodoScreen extends StatefulWidget {
  final Function(TodoEntity entity) onSave;
  const CreateTodoScreen({super.key, required this.onSave});

  @override
  State<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  final TextEditingController controllerTitle = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();
  DateTime? selectedDateTime;

  final TodoEntity todoEntity = TodoEntity.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create todo'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DateSelectWidget(
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
          widget.onSave.call(editedTodo);
          Navigator.pop(context);
        },

        child: Icon(Icons.save),
      ),
    );
  }
}
