
import 'package:flutter/material.dart';

import '../core/entities/todo_entity.dart';

class TodoCardWidget extends StatelessWidget {
  final TodoEntity entity;
  final Function() onTap;
  final Function() onDelete;
  final Function() onComplete;
  const TodoCardWidget({
    super.key,
    required this.entity,
    required this.onTap,
    required this.onDelete,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final active = entity.isCompleted;
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: active ? Colors.lightGreen : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      entity.title,
                      style: TextStyle(
                        color: active ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () => onDelete.call(),
                    icon: Icon(Icons.delete_forever),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => onComplete.call(),
                    child: Checkbox(
                      value: entity.isCompleted,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                entity.description,
                maxLines: 4,
                style: TextStyle(
                  color: active ? Colors.white : Colors.black38,
                  fontSize: 14,
                ),
              ),
              Row(
                children: [
                  Spacer(),
                  Text(
                    entity.dateTime.toString(),
                    style: TextStyle(
                      color: active ? Colors.white : Colors.black,
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
