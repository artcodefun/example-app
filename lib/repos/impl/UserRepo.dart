import 'package:test_app/models/User.dart';
import 'package:test_app/models/abstract/Serializer.dart';
import 'BasicRepository.dart';
import 'package:test_app/repos/UserRepository.dart';
import 'package:test_app/services/ApiHandler.dart';
import 'package:test_app/services/Storage.dart';

/// Default implementation of [UserRepository]
class UserRepo extends BasicRepository<User> implements UserRepository {
  UserRepo(
      {required Storage storage,
      required ApiHandler apiHandler,
      required String apiPath,
      required Serializer<User> serializer,
      String? savePath})
      : super(
            storage: storage,
            apiHandler: apiHandler,
            apiPath: apiPath,
            serializer: serializer,
            savePath: savePath,
            preSave: (u) async {
              return u.copyWith(
                avatar: "https://picsum.photos/seed/users${u.id}/200/200",
              );
            });
}
