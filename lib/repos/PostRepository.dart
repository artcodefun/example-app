import 'package:test_app/models/Post.dart';
import 'package:test_app/repos/StreamableRepository.dart';

import '../models/User.dart';

/// StreamableRepository with [Post]-specific functionality
abstract class PostRepository implements StreamableRepository<Post>{



  /// Pulls last posts created by given [User]
  ///
  /// if pulling from remote repository is unavailable should load from local one
  Future<List<Post>> getPostsFromUser(User user, int limit, int page);


}