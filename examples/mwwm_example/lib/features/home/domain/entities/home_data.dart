import 'package:equatable/equatable.dart';
import 'package:mwwm_example/features/home/domain/entities/post.dart';

class HomeData extends Equatable {
  final List<Post> posts;

  @override
  List<Object?> get props => [posts];

  const HomeData({
    required this.posts,
  });
}
