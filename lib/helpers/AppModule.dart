import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_app/models/AuthData.dart';
import 'package:test_app/models/Category.dart';
import 'package:test_app/models/Comment.dart';
import 'package:test_app/models/Post.dart';
import 'package:test_app/models/User.dart';
import 'package:test_app/repos/CategoryRepository.dart';
import 'package:test_app/repos/impl/AuthDataLoader.dart';
import 'package:test_app/repos/impl/CategoryRepo.dart';
import 'package:test_app/repos/impl/CommentRepo.dart';
import 'package:test_app/repos/impl/PostRepo.dart';
import 'package:test_app/repos/impl/UserRepo.dart';
import 'package:test_app/repos/AuthLocalDataLoader.dart';
import 'package:test_app/repos/CommentRepository.dart';
import 'package:test_app/repos/PostRepository.dart';
import 'package:test_app/repos/UserRepository.dart';
import 'package:test_app/services/ApiHandler.dart';
import 'package:test_app/services/Storage.dart';
import 'package:test_app/services/impl/DioApiHandler.dart';
import 'package:test_app/services/impl/HiveStorage.dart';

import 'Endpoints.dart';

/// Manages dependency injection
class AppModule {
  Future<Injector> initialise(Injector injector) async {
    // initializing external packages
    await GlobalConfiguration().loadFromAsset("app_settings");

    //then load services
    var hs = HiveStorage();
    await hs.init((await getApplicationDocumentsDirectory()).path);

    injector.map<Storage>((i) => hs, isSingleton: true);

    var dah = DioApiHandler();
    await dah.init(GlobalConfiguration().get("baseURL"));

    injector.map<ApiHandler>((i) => dah, isSingleton: true);

    //then load repositories
    await hs.registerType<User, UserAdapter>(Endpoints.userSavePath, UserAdapter());
    injector.map<UserRepository>(
        (i) => UserRepo(
            storage: i.get<Storage>(),
            apiHandler: i.get<ApiHandler>(),
            apiPath: Endpoints.userApiPath,
            serializer: UserSerializer(),
            savePath: Endpoints.userSavePath),
        isSingleton: true);

    await hs.registerType<Post, PostAdapter>(Endpoints.postSavePath, PostAdapter());
    injector.map<PostRepository>(
        (i) => PostRepo(
            storage: i.get<Storage>(),
            apiHandler: i.get<ApiHandler>(),
            apiPath: Endpoints.postApiPath,
            serializer: PostSerializer(),
            userApiPath: Endpoints.userApiPath,
            savePath: Endpoints.postSavePath),
        isSingleton: true);

    await hs.registerType<Comment, CommentAdapter>(
        Endpoints.commentSavePath, CommentAdapter());
    injector.map<CommentRepository>(
        (i) => CommentRepo(
            storage: i.get<Storage>(),
            apiHandler: i.get<ApiHandler>(),
            apiPath: Endpoints.commentApiPath,
            serializer: CommentSerializer(),
            savePath: Endpoints.commentSavePath,
            postApiPath: Endpoints.postApiPath),
        isSingleton: true);

    await hs.registerType<Category, CategoryAdapter>(
        Endpoints.categorySavePath, CategoryAdapter());
    injector.map<CategoryRepository>(
            (i) => CategoryRepo(
            storage: i.get<Storage>(),
            apiHandler: i.get<ApiHandler>(),
            apiPath: Endpoints.categoryApiPath,
            serializer: CategorySerializer(),
            savePath: Endpoints.categorySavePath),
        isSingleton: true);

    await hs.registerType<AuthData, AuthDataAdapter>(
        Endpoints.authDataSavePath, AuthDataAdapter());
    injector.map<AuthLocalDataLoader>(
            (i) => AuthDataLoader(
            storage: i.get<Storage>(),
            savePath: Endpoints.authDataSavePath),
        isSingleton: true);


    return injector;
  }
}
