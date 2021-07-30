import 'package:mwwm_example/features/home/data/models/post_model.dart';
import 'package:mwwm_example/features/home/domain/entities/home_data.dart';
import 'package:mwwm_example/features/home/domain/entities/post.dart';

class HomeDataModel extends HomeData {
  const HomeDataModel({
    required List<Post> posts,
  }) : super(
          posts: posts,
        );

  factory HomeDataModel.fromJson(List<dynamic> json) {
    final posts = <Post>[];

    for (final value in json) {
      posts.add(PostModel.fromJson(value as Map<String, dynamic>));
    }

    return HomeDataModel(posts: posts);
  }
}
