import 'package:flutter/material.dart';

import '../core/entities/todo_entity.dart';

class TodoCardWidget extends StatefulWidget {
  final TodoEntity entity;
  final Function() onTap;
  final Function() onDelete;
  final Function(TodoEntity entity) onComplete;
  const TodoCardWidget({
    super.key,
    required this.entity,
    required this.onTap,
    required this.onDelete,
    required this.onComplete,
  });

  @override
  State<TodoCardWidget> createState() => _TodoCardWidgetState();
}

class _TodoCardWidgetState extends State<TodoCardWidget> {
  bool isCompleted = false;

  @override
  void initState() {
    isCompleted = widget.entity.isCompleted;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        color: isCompleted ? Colors.lightGreen : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.entity.title,
                      style: TextStyle(
                        color: isCompleted ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () => widget.onDelete.call(),
                    icon: Icon(Icons.delete_forever),
                  ),
                  SizedBox(width: 10),
                  Checkbox(
                    value: isCompleted,
                    onChanged: (value) {
                      if (value == null) return;
                      isCompleted = value;
                      final editedEntity = widget.entity.copyWith(isCompleted: isCompleted);
                      widget.onComplete.call(editedEntity);
                      setState(() {});
                    },
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                widget.entity.description,
                maxLines: 4,
                style: TextStyle(
                  color: isCompleted ? Colors.white : Colors.black38,
                  fontSize: 14,
                ),
              ),
              Row(
                children: [
                  Spacer(),
                  Text(
                    widget.entity.dateTime.toString(),
                    style: TextStyle(
                      color: isCompleted ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
