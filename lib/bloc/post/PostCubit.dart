import 'package:test_app/bloc/RepoListeningCubit.dart';
import 'package:test_app/bloc/post/PostState.dart';
import 'package:test_app/models/Post.dart';
import 'package:test_app/repos/PostRepository.dart';

class PostCubit extends RepoListeningCubit<PostState, Post>{
  PostCubit({ required Post post, required PostRepository repo}) : _repo=repo, super(initial: PostState(post: post), repo: repo);

  final PostRepository _repo;

  @override
  onUpdateFromRepo(Post model) {
    if(state.post.id!=model.id) return;
    if(state.post==model) return;
    emit(state.copyWith(post: model));
  }

}