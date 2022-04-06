import 'package:test_app/models/Category.dart';
import 'package:test_app/models/abstract/Serializer.dart';
import 'BasicRepository.dart';
import 'package:test_app/repos/CategoryRepository.dart';
import 'package:test_app/services/ApiHandler.dart';
import 'package:test_app/services/Storage.dart';

/// Default implementation of [CategoryRepository]
class CategoryRepo extends BasicRepository<Category>
    implements CategoryRepository {
  CategoryRepo(
      {required Storage storage,
      required ApiHandler apiHandler,
      required String apiPath,
      required Serializer<Category> serializer,
      String? savePath})
      : super(
            storage: storage,
            apiHandler: apiHandler,
            apiPath: apiPath,
            serializer: serializer,
            savePath: savePath);

  @override
  Future<List<Category>> loadAll() async {
    List<Category>? categories = await apiHandler.get(apiPath, {}, listConverter);
    if (categories == null) {
      return (await storage.getAll<Category>(path: savePath)).toList();
    }
    for(int i=0; i<categories.length; i++){
      categories[i] = await save(categories[i]);
    }
    return categories;
  }
}
