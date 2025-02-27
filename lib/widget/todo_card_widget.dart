import 'package:flutter/material.dart';

import '../core/entities/todo_entity.dart';

class TodoCardWidget extends StatelessWidget {
  final TodoEntity entity;
  const TodoCardWidget({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    final active = entity.isCompleted;
    return Card(
      color: active ? Colors.lightGreen : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  entity.title,
                  style: TextStyle(
                    color: active ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                Text(
                  entity.id.toString(),
                  style: TextStyle(
                    color: active ? Colors.white : Colors.black,
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
    );
  }
}
