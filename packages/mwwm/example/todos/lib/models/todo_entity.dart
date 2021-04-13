import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class TodoEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final bool isCompleted;

  const TodoEntity(
    this.id,
    this.title,
    this.description,
    this.isCompleted,
  );

  @override
  List<Object> get props => [
        id,
        title,
        description,
        isCompleted,
      ];
}
