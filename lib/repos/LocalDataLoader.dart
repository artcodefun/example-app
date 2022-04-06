import 'package:test_app/models/abstract/Model.dart';

/// Manages locally stored data of type T
abstract class LocalDataLoader<T extends Model>{
  /// Tries to load model of type [T] with id [id]
  ///
  /// if model cannot be found returns null
  Future<T?> load(dynamic id);


  /// Tries to save [model] to local storage
  Future save(T model);

  /// Tries to delete model by it's [id]
  Future delete(dynamic id);
}
