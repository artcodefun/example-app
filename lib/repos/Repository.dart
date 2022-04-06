import 'package:test_app/models/abstract/Model.dart';

/// Manages locally and remotely stored data of type T
abstract class Repository<T extends Model>{
  /// Tries to load model of type [T] with id [id]
  ///
  /// should first try to load from local storage and then pull from remote one
  ///
  /// if model cannot be found returns null
  Future<T?> load(dynamic id);

  /// Tries to load models of type [T] with [beginId] <= id <= [endId]
  ///
  /// should first try to load from local storage and then pull from remote one
  Future<List<T>> loadSet(int beginId, int endId);

  /// Tries to pull model from remote storage and then update/save it locally
  ///
  /// looks for model of type [T] with id [id]
  /// if model cannot be found returns null
  Future<T?> pull(dynamic id);

  /// Tries to pull [n] last models from remote storage
  Future<List<T>> pullLast(int n);

  /// Tries to update model from remote storage with [model] value
  Future push(T model);
}
