import 'package:flutter/material.dart';
import 'package:test_app/models/Comment.dart';
import 'package:test_app/models/Post.dart';
import 'package:test_app/models/abstract/Serializer.dart';
import 'package:test_app/repos/CommentRepository.dart';
import 'package:test_app/services/ApiHandler.dart';
import 'package:test_app/services/Storage.dart';

import 'BasicRepository.dart';

/// Default implementation of [CommentRepository]
class CommentRepo extends BasicRepository<Comment>
    implements CommentRepository {
  CommentRepo(
      {required Storage storage,
      required ApiHandler apiHandler,
      required String apiPath,
      required Serializer<Comment> serializer,
      required this.postApiPath,
      String? savePath})
      : super(
            storage: storage,
            apiHandler: apiHandler,
            apiPath: apiPath,
            serializer: serializer,
            savePath: savePath);

  final String postApiPath;

  @override
  Future<List<Comment>> getCommentsForPost(Post post) async {
    List<Comment> comments;
    try {
      comments = await apiHandler.get(
          postApiPath + "${post.id}/" + apiPath, {}, listConverter);
    } catch (e) {
      return (await storage.getAll<Comment>(path: savePath))
          .where((c) => c.postId == post.id)
          .toList();
    }

    for (int i = 0; i < comments.length; i++) {
      comments[i] = await save(comments[i]);
    }
    return comments;
  }
}
