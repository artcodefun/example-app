import 'package:test_app/models/Post.dart';
import 'package:test_app/models/User.dart';
import 'package:test_app/models/abstract/Serializer.dart';
import 'BasicRepository.dart';
import 'package:test_app/repos/PostRepository.dart';
import 'package:test_app/services/ApiHandler.dart';
import 'package:test_app/services/Storage.dart';

/// Default implementation of [PostRepository]
class PostRepo extends BasicRepository<Post> implements PostRepository {
  PostRepo(
      {required Storage storage,
      required ApiHandler apiHandler,
      required String apiPath,
      required Serializer<Post> serializer,
      required this.userApiPath,
      String? savePath})
      : super(
            storage: storage,
            apiHandler: apiHandler,
            apiPath: apiPath,
            serializer: serializer,
            savePath: savePath,
            preSave: (p) async {
              return p.copyWith(
                imageUrl: "https://picsum.photos/seed/posts${p.id}/400/200",
              );
            });

  final String userApiPath;

  @override
  Future<List<Post>> getPostsFromUser(User user, int limit, int page) async {
    List<Post> posts;

    try {
      posts = await apiHandler.get(userApiPath + "${user.id}/" + apiPath,
          {"_sort": "id", "_order": "desc", "_limit": limit, "_page": page}, listConverter);
    } catch (e) {
      posts =  (await storage.getAll<Post>(path: savePath))
          .where((p) => p.userId == user.id)
          .toList()
        ..sort((a, b) => b.id.compareTo(a.id));
      return posts.skip((page-1)*limit).take(limit).toList();
    }

    for (int i = 0; i < posts.length; i++) {
      posts[i] = await save(posts[i]);
    }
    return posts..sort((a, b) => b.id.compareTo(a.id));
  }
}
