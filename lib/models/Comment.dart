import 'package:hive/hive.dart';

import 'abstract/Model.dart';
import 'abstract/Serializer.dart';

part 'Comment.g.dart';

@HiveType(typeId: 2)
class Comment extends Model {
  Comment({
    required this.id,
    required this.userId,
    required this.likes,
    required this.body,
    required this.postId,
  });

  @override
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int userId;
  @HiveField(2)
  final int likes;
  @HiveField(3)
  final String body;
  @HiveField(4)
  final int postId;

  Comment copyWith({
    int? id,
    int? userId,
    int? likes,
    String? body,
    int? postId,
  }) {
    return Comment(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      likes: likes ?? this.likes,
      body: body ?? this.body,
      postId: postId ?? this.postId,
    );
  }

  @override
  List<Object?> get props => [id,userId,likes,body,postId];
}

class CommentSerializer implements Serializer<Comment> {
  @override
  Comment fromMap(Map<String, dynamic> map) {
    return Comment(
        id: map["id"],
        userId: map["userId"],
        likes: map["likes"],
        body: map["body"],
        postId: map["postId"]);
  }

  @override
  Map<String, dynamic> toMap(Comment model) {
    return {
      "id" : model.id,
      "userId" : model.userId,
      "likes" : model.likes,
      "body" : model.body,
      "postId" : model.postId,
    };
  }
}
