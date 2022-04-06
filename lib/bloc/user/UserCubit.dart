
import 'package:test_app/bloc/RepoListeningCubit.dart';
import 'package:test_app/bloc/user/UserState.dart';
import 'package:test_app/models/User.dart';
import 'package:test_app/repos/UserRepository.dart';

class UserCubit extends RepoListeningCubit<UserState, User>{
  UserCubit({required UserRepository repo, User? initialUser}) : _repo=repo, super(initial: UserState(user: initialUser), repo:  repo);

  final UserRepository _repo;

  loadUser(int id) async {
    User? user = await _repo.load(id);
    emit(state.copyWith(user: user));
  }


  @override
  onUpdateFromRepo(User model) {
    if(state.user==null) return;
    if(state.user!.id!=model.id) return;
    if(state.user==model) return;
    emit(state.copyWith(user: model));
  }


}