import 'package:test_app/models/Post.dart';

class PostState{
  final Post post;

  PostState copyWith({
    Post? post,
  }) {
    return PostState(
      post: post ?? this.post,
    );
  }

  const PostState({
    required this.post,
  });
}