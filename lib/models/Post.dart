import 'package:hive/hive.dart';
import 'package:test_app/models/abstract/Model.dart';
import 'package:test_app/models/abstract/Serializer.dart';

part 'Post.g.dart';

@HiveType(typeId: 1)
class Post extends Model{
  Post({
    required this.id,
    required this.title,
    required this.userId,
    required this.content,
    required this.likes,
    required this.hits,
    required this.categoryId,
    required this.imageUrl,
  });

  @override
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final int userId;
  @HiveField(3)
  final String content;
  @HiveField(4)
  final int likes;
  @HiveField(5)
  final int hits;
  @HiveField(6)
  final int categoryId;
  @HiveField(7)
  final String imageUrl;

  Post copyWith({
    int? id,
    String? title,
    int? userId,
    String? content,
    int? likes,
    int? hits,
    int? categoryId,
    String? imageUrl,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      likes: likes ?? this.likes,
      hits: hits ?? this.hits,
      categoryId: categoryId ?? this.categoryId,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props =>[id, title, userId, content, likes, hits, categoryId, imageUrl];
}

class PostSerializer implements Serializer<Post> {
  @override
  Post fromMap(Map<String, dynamic> map) {
    return Post(
      id: map["id"],
      title: map["title"],
      userId: map["userId"],
      content: map["content"],
      likes: map["likes"],
      hits: map["hits"],
      categoryId: map["categoryId"],
      imageUrl: map["imageUrl"],
    );
  }

  @override
  Map<String, dynamic> toMap(Post model) {
    return {
      "id" : model.id,
      "title" : model.title,
      "userId" : model.userId,
      "content" : model.content,
      "likes" : model.likes,
      "hits" : model.hits,
      "categoryId" : model.categoryId,
      "imageUrl" : model.imageUrl,
    };
  }
}
