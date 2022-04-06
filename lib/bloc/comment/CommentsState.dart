import 'package:test_app/models/Comment.dart';

class CommentsState {
  final List<Comment> comments;

  const CommentsState({
    this.comments = const [],
  });

  CommentsState copyWith({
    List<Comment>? comments,
  }) {
    return CommentsState(
      comments: comments ?? this.comments,
    );
  }
}
