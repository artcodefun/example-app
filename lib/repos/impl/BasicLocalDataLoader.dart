
import 'package:test_app/models/abstract/Model.dart';
import 'package:test_app/repos/LocalDataLoader.dart';
import 'package:test_app/services/Storage.dart';

/// Implements basic [LocalDataLoader] functionality
class BasicLocalDataLoader<T extends Model> implements LocalDataLoader<T>{

  /// Depends on local [storage] with type-specific [savePath]
  BasicLocalDataLoader(
      {required Storage storage,
        String? savePath
      })
      : _storage = storage,
        _savePath = savePath;

  final Storage _storage;
  final String? _savePath;

  @override
  Future<T?> load(id) async {
    T? model = await _storage.findById(id, path: _savePath);
    return model;
  }

  @override
  Future save(T model) async {
    await _storage.save(model, path: _savePath);
  }

  @override
  Future delete(id) async{
    await _storage.delete<T>(id, path: _savePath);
  }

}