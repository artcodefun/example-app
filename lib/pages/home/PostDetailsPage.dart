import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:provider/provider.dart';
import 'package:test_app/bloc/comment/CommentsCubit.dart';
import 'package:test_app/bloc/post/PostCubit.dart';
import 'package:test_app/bloc/user/UserCubit.dart';
import 'package:test_app/components/PostDetailedView.dart';
import 'package:test_app/components/SafeScroll.dart';
import 'package:test_app/generated/l10n.dart';
import 'package:test_app/models/Post.dart';

class PostDetailsPage extends StatelessWidget {
  const PostDetailsPage({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).post_details),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (ctx) => PostCubit(
                  post: post,
                  repo: Provider.of<Injector>(context, listen: false).get())),
          BlocProvider(
              create: (ctx) => CommentsCubit(
                  repo: Provider.of<Injector>(context, listen: false).get())
                ..loadCommentsForPost(post)),
          BlocProvider(
              create: (ctx) => UserCubit(
                  repo: Provider.of<Injector>(context, listen: false).get())
                ..loadUser(post.userId)),
        ],
        child: const SafeScroll(
            child: PostDetailedView()),
      ),
    );
  }
}
