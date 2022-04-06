import 'package:test_app/models/AuthData.dart';
import 'package:test_app/repos/impl/BasicLocalDataLoader.dart';
import 'package:test_app/repos/AuthLocalDataLoader.dart';
import 'package:test_app/services/Storage.dart';

/// Default implementation of [AuthLocalDataLoader]
class AuthDataLoader extends BasicLocalDataLoader<AuthData> implements AuthLocalDataLoader {
  AuthDataLoader(
      {required Storage storage,
        String? savePath})
      : super(
      storage: storage,
      savePath: savePath);

}