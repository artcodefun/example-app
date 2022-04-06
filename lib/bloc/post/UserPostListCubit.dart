import 'package:test_app/bloc/post/PostListCubit.dart';
import 'package:test_app/bloc/post/PostListState.dart';
import 'package:test_app/models/Post.dart';
import 'package:test_app/repos/PostRepository.dart';

import '../../models/User.dart';


/// Provides posts created by some user to listeners
class UserPostListCubit extends PostListCubit {
  UserPostListCubit({required PostRepository repo, required this.user, int frameSize=30, double lowUpdateLimit=0.20, double highUpdateLimit=0.80}):
        super(repo:repo, frameSize:frameSize, lowUpdateLimit:lowUpdateLimit, highUpdateLimit: highUpdateLimit);

  User user;

  
  @override
  loadLast() async {
    emit(state.copyWith(status: PostListStatus.initializing));
    var posts = await repo.getPostsFromUser(user, frameSize, 1);
    posts.sort((a, b) => b.id.compareTo(a.id));
    emit(PostListState(
        status: PostListStatus.active,
        posts: posts,
        baseOffset: 0,
        canLoadNewer: false));
  }
  
  @override
  Future loadNewer(int amount) async {
    emit(state.copyWith(status: PostListStatus.loading));
    int page = (state.baseOffset~/amount).clamp(1, double.maxFinite.toInt());
    List<Post> newerPosts;

    try {
      newerPosts = await repo.getPostsFromUser(user, amount, page);
    }catch(e){newerPosts=[];}

    if (newerPosts.isEmpty) {
      emit(state.copyWith(canLoadNewer: false));
      return;
    }

    newerPosts.sort((a, b) => b.id.compareTo(a.id));
    List<Post> posts =
        newerPosts + state.posts.take(frameSize - newerPosts.length).toList();

    emit(state.copyWith(
        status: PostListStatus.active,
        posts: posts,
        baseOffset: state.baseOffset - newerPosts.length,
        canLoadOlder: true,
        canLoadNewer: true));
  }
  
  @override
  Future loadOlder(int amount) async {
    emit(state.copyWith(status: PostListStatus.loading));
    int page = (state.baseOffset+state.posts.length)~/amount+1;
    List<Post> olderPosts;

    try{
      olderPosts = await repo.getPostsFromUser(user, amount, page);}
    catch(e){olderPosts=[];}

    if (olderPosts.isEmpty) {
      emit(state.copyWith(canLoadOlder: false));
      return;
    }
    olderPosts.sort((a, b) => b.id.compareTo(a.id));
    List<Post> posts =
        state.posts.skip(olderPosts.length).toList() + olderPosts;

    emit(state.copyWith(
        status: PostListStatus.active,
        posts: posts,
        baseOffset: state.baseOffset + olderPosts.length,
        canLoadOlder: true,
        canLoadNewer: true));
  }
  
}
