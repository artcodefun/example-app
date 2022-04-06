import 'package:test_app/models/Comment.dart';
import 'package:test_app/models/Post.dart';
import 'package:test_app/repos/StreamableRepository.dart';

/// StreamableRepository with [Comment]-specific functionality
abstract class CommentRepository implements StreamableRepository<Comment>{

  /// Pulls last comments for given [post]
  ///
  /// if pulling from remote repository is unavailable should load from local one
  Future<List<Comment>> getCommentsForPost(Post post);
}