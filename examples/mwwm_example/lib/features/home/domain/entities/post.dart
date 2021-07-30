import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String title;
  final String description;

  @override
  List<Object?> get props => [title, description];

  const Post({
    required this.title,
    required this.description,
  });
}
