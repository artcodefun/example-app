import 'dart:async';

import 'package:test_app/models/abstract/Model.dart';
import 'package:test_app/models/abstract/Serializer.dart';
import 'package:test_app/repos/StreamableRepository.dart';
import 'package:test_app/services/ApiHandler.dart';
import 'package:test_app/services/Storage.dart';

/// Implements basic [StreamableRepository] functionality
class BasicRepository<T extends Model> implements StreamableRepository<T> {
  /// Depends on local [storage] with type-specific [savePath] and
  /// [apiHandler] with [apiPath] and [serializer] for remote storage communication
  ///
  /// [preSave] could be provided in order to do something with model right before saving to [storage]
  /// like downloading files that model linked to
  BasicRepository(
      {required this.storage,
      required this.apiHandler,
      required this.apiPath,
      required this.serializer,
      this.savePath,
      this.preSave});

  final Storage storage;
  final ApiHandler apiHandler;
  final String apiPath;
  final Serializer<T> serializer;
  final String? savePath;

  final StreamController<T> _controller = StreamController.broadcast();

  _pathFromId(dynamic id) => apiPath + "$id";

  ApiConverter<T> get converter =>
      (d) => serializer.fromMap(d as Map<String, dynamic>);

  ApiReverseConverter<T> get reverseConverter => serializer.toMap;

  ApiConverter<List<T>> get listConverter => (d) {
        return (d as List)
            .map((e) => serializer.fromMap(e as Map<String, dynamic>))
            .toList();
      };

  final Future<T> Function(T model)? preSave;

  Future<T> save(T model) async {
    if (preSave != null) {
      model = await preSave!(model);
    }
    await storage.save(model, path: savePath);
    _notifyListeners(model);
    return model;
  }

  _notifyListeners(T model) {
    _controller.sink.add(model);
  }

  @override
  Future<T?> load(id) async {
    T? model = await storage.findById(id, path: savePath);
    if (model != null) {
      return model;
    }
    model = await pull(id);
    return model;
  }

  @override
  Future<List<T>> loadSet(int beginId, int endId) async {
    List<T> models = [];
    List<int> notFound = [];

    for (int id = beginId; id <= endId; id++) {
      T? model = await load(id);
      if (model != null) {
        models.add(model);
      } else {
        notFound.add(id);
      }
    }

    return models;
  }

  @override
  Future<T?> pull(id) async {
    try {
      T model = await apiHandler.get(_pathFromId(id), {}, converter);

      model = await save(model);
      return model;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<T>> pullLast(int n) async {
    List<T> models;
    models = await apiHandler.get<List<T>>(
        apiPath, {"_sort": "id", "_order": "desc", "_limit": n}, listConverter);

    for (int i = 0; i < models.length; i++) {
      models[i] = await save(models[i]);
    }
    return models;
  }

  @override
  Future push(T model) async {
    await apiHandler.post(_pathFromId(model.id), model, reverseConverter);
    await save(model);
  }

  @override
  Stream<T> get stream => _controller.stream;
}
