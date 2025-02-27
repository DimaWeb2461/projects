import 'package:flutter/foundation.dart';

class TodoEntity {
  final int id;
  final String title;
  final String description;
  final DateTime dateTime;
  final bool isCompleted;

  TodoEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.isCompleted,
  });


  factory TodoEntity.empty() {
    return TodoEntity(
      id: DateTime.now().microsecondsSinceEpoch,
      title: '',
      description: '',
      dateTime: DateTime.now(),
      isCompleted: false,
    );
  }

  TodoEntity copyWith({
    String? title,
    String? description,
    DateTime? dateTime,
    bool? isCompleted,
  }) {
    return TodoEntity(
      id: id ,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
