import 'package:test_app/bloc/RepoListeningCubit.dart';
import 'package:test_app/models/Category.dart';
import 'package:test_app/repos/CategoryRepository.dart';

import 'CategoriesState.dart';

class CategoriesCubit extends RepoListeningCubit<CategoriesState, Category> {
  CategoriesCubit({required CategoryRepository repo})
      : _repo = repo,
        super(initial: const CategoriesState(), repo: repo);

  final CategoryRepository _repo;

  loadAllCategories() async {
    List<Category> categories = await _repo.loadAll();
    emit(state.copyWith(categories: categories));
  }

  @override
  onUpdateFromRepo(Category model) {
    int index =
        state.categories.indexWhere((element) => element.id == model.id);
    if (index == -1) {
      return;
    }
    if (model == state.categories[index]) {
      return;
    }
    emit(state.copyWith(categories: state.categories..[index] = model));
  }
}
