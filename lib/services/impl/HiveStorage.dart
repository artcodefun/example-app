import 'package:hive/hive.dart';
import 'package:test_app/models/abstract/Model.dart';
import 'package:test_app/services/Storage.dart';

/// Storage implementation for Hive database
class HiveStorage implements Storage<TypeAdapter>{
  
  @override
  Future<T?> findById<T extends Model>(dynamic id, {String? path}) async {
    return Hive.box<T>(path ?? pathMap[T]!.first).get(id);
  }

  @override
  Future<Iterable<T>> getAll<T extends Model>({String? path}) async {
    return Hive.box<T>(path ?? pathMap[T]!.first).values.cast<T>();
  }

  @override
  Future<dynamic> save<T extends Model>(T model, {String? path}) async {
    await Hive.box<T>(path ?? pathMap[T]!.first).put(model.id, model);
    return model.id;
  }

  @override
  Future delete<T extends Model>(dynamic id, {String? path}) async {
    await Hive.box<T>(path ?? pathMap[T]!.first).delete(id);
  }

  @override
  Future<int> count<T extends Model>({String? path}) async {
    return Hive.box<T>(path ?? pathMap[T]!.first).length;
  }

  Map<Type, List<String>> pathMap = {};

  @override
  Future registerType<T extends Model, A extends TypeAdapter>(String path, A adapter) async{
    if(pathMap[T]==null){
      Hive.registerAdapter<T>(adapter as TypeAdapter<T>);
      pathMap[T]=[];
    }

    if(pathMap[T]!.contains(path)) {
      return;
    }

    await Hive.openBox<T>(path);
    pathMap[T]!.add(path);
  }

  bool _initDone = false;

  @override
  Future init(String savePath) async{
    if (_initDone) return;
    Hive.init(savePath);

    _initDone=true;
  }

  
}