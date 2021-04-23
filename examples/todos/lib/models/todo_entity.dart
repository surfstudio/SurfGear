import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class TodoEntity extends Equatable {
  const TodoEntity({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.description,
  });

  final int id;
  final String title;
  final String description;
  final bool isCompleted;

  @override
  List<Object> get props => [
        id,
        title,
        description,
        isCompleted,
      ];
}
