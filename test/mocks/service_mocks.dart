import 'package:test_app/models/abstract/Model.dart';
import 'package:test_app/services/ApiHandler.dart';
import 'package:test_app/services/Storage.dart';
import 'Mock.dart';

/// A class which mocks [ApiHandler].
class MockApiHandler extends Mock implements ApiHandler {

  @override
  Future<T> get<T>(String apiPath, Map<String, dynamic> query, ApiConverter<T> converter) async{
    return tryAnswer("get", [apiPath, query, converter]);
  }

  @override
  Future delete(String apiPath) async{
    return tryAnswer("delete", [apiPath]);
  }

  @override
  Future download(String apiPath, String localPath) async{
    return tryAnswer("download", [apiPath, localPath]);
  }

  @override
  Future init(String baseUrl) async{
    return tryAnswer("init", [baseUrl]);
  }

  @override
  Future post<T>(String apiPath, T data, ApiReverseConverter<T> converter) async{
    return tryAnswer("post", [apiPath, data, converter]);
  }

  @override
  Future put<T>(String apiPath, T data, ApiReverseConverter<T> converter) async{
    return tryAnswer("put", [apiPath, data, converter]);
  }

}

/// A class which mocks [Storage].
class MockStorage<AA> extends Mock implements Storage<AA> {


@override
  Future save<T extends Model>(T model, {String? path}) async{
  return tryAnswer("save", [model, path]);
  }

  @override
  Future<int> count<T extends Model>({String? path}) async{
    return tryAnswer("count", [path]);
  }

  @override
  Future delete<T extends Model>(id, {String? path}) async{
    return tryAnswer("delete", [id, path]);
  }

  @override
  Future<T?> findById<T extends Model>(id, {String? path})async {
    return tryAnswer("findById", [id, path]);
  }

  @override
  Future<Iterable<T>> getAll<T extends Model>({String? path}) async{
    return tryAnswer("getAll", [path]);
  }

  @override
  Future init(String savePath) async{
    return tryAnswer("savePath", [savePath]);
  }

  @override
  Future registerType<T extends Model, A extends AA>(String path, A adapter) async {
    return tryAnswer("registerType", [path, adapter]);
  }

}
