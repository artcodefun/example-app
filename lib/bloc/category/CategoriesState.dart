import 'package:test_app/models/Category.dart';

class CategoriesState{
  final List<Category> categories;

  const CategoriesState({
    this.categories=const[],
  });

  CategoriesState copyWith({
    List<Category>? categories,
  }) {
    return CategoriesState(
      categories: categories ?? this.categories,
    );
  }
}