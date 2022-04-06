import 'package:test_app/bloc/RepoListeningCubit.dart';
import 'package:test_app/bloc/post/PostListState.dart';
import 'package:test_app/models/Post.dart';
import 'package:test_app/repos/PostRepository.dart';


/// Provides posts to listeners
class PostListCubit extends RepoListeningCubit<PostListState, Post> {
  PostListCubit({required this.repo, this.frameSize=30, this.lowUpdateLimit=0.20, this.highUpdateLimit=0.80})
      : super(initial: const PostListState(posts: []), repo: repo);

  final PostRepository repo;

  /// Maximum amount of items in [PostListState]
  final int frameSize;

  /// Defines when newer posts should be loaded
  ///
  /// used in [loadPostWithFrameAutoUpdate]
  final double lowUpdateLimit;

  /// Defines when older posts should be loaded
  ///
  /// used in [loadPostWithFrameAutoUpdate]
  final double highUpdateLimit;


  bool _updating =false;
  final double _updatingAmount =0.25;

  /// Loads post based on its [position] and updates frame with new posts if needed
  loadPostWithFrameAutoUpdate(int position){

    int framePosition =position-state.baseOffset;
    int loadItems =(frameSize*_updatingAmount).toInt();

    if(framePosition<frameSize*lowUpdateLimit && state.canLoadNewer && !_updating){
      _updating=true;
      loadNewer(loadItems).whenComplete(() => _updating=false);
    }


    if(framePosition>frameSize*highUpdateLimit && state.canLoadOlder && !_updating){
      _updating=true;
      loadOlder(loadItems).whenComplete(() => _updating=false);
    }

    return state.getPost(position);
  }


  /// Loads latest posts into frame
  loadLast() async {
    emit(state.copyWith(status: PostListStatus.initializing));
    var posts = await repo.pullLast(frameSize);
    posts.sort((a, b) => b.id.compareTo(a.id));
    emit(PostListState(
        status: PostListStatus.active,
        posts: posts,
        baseOffset: 0,
        canLoadNewer: false));
  }

  /// Updates frame with newer posts
  Future loadNewer(int amount) async {
    emit(state.copyWith(status: PostListStatus.loading));
    int fromId = state.posts.first.id + 1;
    List<Post> newerPosts;

    try {
      newerPosts = await repo.loadSet(fromId, fromId + amount);
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

  /// Updates frame with older posts
  Future loadOlder(int amount) async {
    emit(state.copyWith(status: PostListStatus.loading));
    int fromId = state.posts.last.id - 1;
    List<Post> olderPosts;

    try{
    olderPosts = await repo.loadSet(fromId - amount, fromId);}
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

  @override
  onUpdateFromRepo(Post model) {
    int index = state.posts.indexWhere((element) => element.id == model.id);
    if (index == -1) {
      return;
    }
    if (model == state.posts[index]) {
      return;
    }
    emit(state.copyWith(posts: state.posts..[index] = model));
  }
}
