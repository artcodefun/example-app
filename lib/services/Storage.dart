
import 'package:test_app/models/abstract/Model.dart';

/// Used to load/save app data locally
///
/// [AbstractAdapter] is an adapter interface used by specific storage
/// e.g. TypeAdapter for Hive
abstract class Storage<AbstractAdapter>{

  /// Should be called before any other actions
  ///
  /// provide [savePath] as base directory for storage files
  Future init(String savePath);

  /// Saves [model] locally
  ///
  /// returns [model]'s id
  ///
  /// use [path] if there are more then one type-specific storages e.g. tables.
  /// if [path] is not provided first registered path will be used
  Future<dynamic> save<T extends Model>(T model, {String? path});

  /// Deletes [model] that was saved locally
  ///
  /// use [path] if there are more then one type-specific storages e.g. tables.
  /// if [path] is not provided first registered path will be used
  Future delete<T extends Model>(dynamic id, {String? path});


  /// Counts all [model] saved locally with [path]
  ///
  /// use [path] if there are more then one type-specific storages e.g. tables.
  /// if [path] is not provided first registered path will be used
  Future<int> count<T extends Model>({String? path});

  /// Tries to find value of type [T] by [id]
  ///
  /// if value cannot be found returns null
  ///
  /// use [path] if there are more then one type-specific storages e.g. tables.
  /// if [path] is not provided first registered path will be used
  Future<T?> findById<T extends Model>(dynamic id,  {String? path});

  /// Returns all stored values of type [T]
  ///
  /// use [path] if there are more then one type-specific storages e.g. tables.
  /// if [path] is not provided first registered path will be used
  Future<Iterable<T>> getAll<T extends Model>({String? path});

  /// Used to create a type-specific storage entity e.g. table in sql-databases or box in hive
  ///
  /// [path] is used as identifier e.g. table's name
  ///
  /// [adapter] is an adapter that's used to convert [T] value
  /// to something that can be stored by specific storage
  Future registerType<T extends Model, A extends AbstractAdapter>(String path, A adapter);

}