import 'package:mwwm_example/features/home/domain/entities/post.dart';

class PostModel extends Post {
  final int id;

  const PostModel({
    required String title,
    required String description,
    required this.id,
  }) : super(
          title: title,
          description: description,
        );

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      title: json['title'] as String,
      description: json['description'] as String,
      id: json['id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['id'] = id;
    return data;
  }
}
