import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/bloc/category/CategoriesCubit.dart';
import 'package:test_app/bloc/post/PostListCubit.dart';
import 'package:test_app/bloc/post/PostListState.dart';
import 'package:test_app/components/PostView.dart';
import 'package:test_app/models/Category.dart';
import 'package:test_app/models/Post.dart';

class PostList extends StatelessWidget {
  const PostList({Key? key}) : super(key: key);

  String? getCategoryName(int id, List<Category> categories) {
    int index = categories.indexWhere((element) => element.id == id);
    if (index == -1) {
      return null;
    }
    return categories[index].name;
  }

  @override
  Widget build(BuildContext context) {
    PostListCubit pc = context.watch();
    CategoriesCubit ctg = context.watch();

    return ListView.builder(
        itemCount: pc.state.posts.length + pc.state.baseOffset,
        addAutomaticKeepAlives: true,
        itemBuilder: (ctx, i) {
          Post p = pc.loadPostWithFrameAutoUpdate(i);
          return
            PostView(post: p,
              categoryName: getCategoryName(p.categoryId, ctg.state.categories),);
        }
    );
  }
}
