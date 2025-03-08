import 'package:flutter/foundation.dart';

class TodoEntity {
  final int id;
  final String title;
  final String description;
  final DateTime? dateTime;
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
      dateTime: null,
      isCompleted: true,
    );
  }

  TodoEntity copyWith({
    String? title,
    String? description,
    DateTime? dateTime,
    bool? isCompleted,
  }) {
    return TodoEntity(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime?.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  factory TodoEntity.fromJson(Map<String, dynamic> json) {
    return TodoEntity(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      dateTime: json['dateTime'] != null
          ? DateTime.parse(json['dateTime'] as String)
          : null,
      isCompleted: json['isCompleted'] as bool,
    );
  }
}
