import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/entities/todo_entity.dart';
import '../cubits/todo_cubit/todo__cubit.dart';
import '../widget/date_select_widget.dart';

class EditTodoScreen extends StatefulWidget {
  final TodoEntity? todo;
  const EditTodoScreen({super.key, this.todo});

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
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      todoEntity = todo;
      controllerTitle.text = todo.title;
      controllerDescription.text = todo.description;
      selectedDateTime = todo.dateTime;
    }
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
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextFormField(
                controller: controllerDescription,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          final editedTodo = todoEntity.copyWith(
            title: controllerTitle.text,
            description: controllerDescription.text,
            dateTime: selectedDateTime,
          );


          context.read<TodoCubit>().saveTodo(editedTodo);

          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
