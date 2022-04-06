
import 'package:test_app/bloc/RepoListeningCubit.dart';
import 'package:test_app/bloc/comment/CommentsState.dart';
import 'package:test_app/models/Comment.dart';
import 'package:test_app/models/Post.dart';
import 'package:test_app/repos/CommentRepository.dart';

class CommentsCubit extends RepoListeningCubit<CommentsState,Comment>{
  CommentsCubit({required CommentRepository repo}) :_repo=repo, super(initial: const CommentsState(), repo: repo);

  final CommentRepository _repo;

  loadCommentsForPost(Post post)async {
    var comments = await _repo.getCommentsForPost(post);
    emit(state.copyWith(comments: comments));
  }

  @override
  onUpdateFromRepo(Comment model) {
    int index=state.comments.indexWhere((c) => c.id==model.id);
    if(index==-1) return;

    emit(state.copyWith(comments: state.comments..[index]=model));
  }

}