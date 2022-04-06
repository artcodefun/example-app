import 'package:test_app/models/Post.dart';

enum PostListStatus{
  created, initializing, loading, active
}

class PostListState{

  const PostListState({
  required this.posts,
    this.status =PostListStatus.created,
    this.baseOffset= 0,
    this.canLoadNewer=true,
    this.canLoadOlder=true
});

  final PostListStatus status;
  final List<Post> posts;
  final int baseOffset;
  final bool canLoadNewer;
  final bool canLoadOlder;


  Post getPost(int position)=>posts[(position-baseOffset).clamp(0, posts.length-1)];

  PostListState copyWith({
    PostListStatus? status,
    List<Post>? posts,
    int? baseOffset,
    bool? canLoadNewer,
    bool? canLoadOlder,
  }) {
    return PostListState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      baseOffset: baseOffset ?? this.baseOffset,
      canLoadNewer: canLoadNewer ?? this.canLoadNewer,
      canLoadOlder: canLoadOlder ?? this.canLoadOlder,
    );
  }
}