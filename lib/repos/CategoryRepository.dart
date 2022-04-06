import 'package:test_app/models/Category.dart';
import 'package:test_app/repos/StreamableRepository.dart';

/// StreamableRepository with [Category]-specific functionality
abstract class CategoryRepository implements StreamableRepository<Category>{
  /// Loads all available categories
  Future<List<Category>> loadAll();
}