import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:provider/provider.dart';
import 'package:test_app/bloc/comment/CommentsCubit.dart';
import 'package:test_app/bloc/post/PostCubit.dart';
import 'package:test_app/bloc/user/UserCubit.dart';
import 'package:test_app/bloc/user/UserState.dart';
import 'package:test_app/components/CommentView.dart';
import 'package:test_app/generated/l10n.dart';

import 'UserView.dart';

class PostDetailedView extends StatelessWidget {
  const PostDetailedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    PostCubit pc = context.watch();
    UserCubit uc = context.watch();
    CommentsCubit cc = context.watch();
    return Container(
      color: theme.colorScheme.surface,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  pc.state.post.imageUrl,
                  fit: BoxFit.cover,
                  color: Colors.black.withOpacity(0.4),
                  colorBlendMode: BlendMode.darken,
                  errorBuilder: (_,__, ___)=>Container(color: theme.colorScheme.onSurface,),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 60, bottom: 60, left: 20, right: 20),
                    child: Text(
                      pc.state.post.title,
                      style: theme.textTheme.headline4
                          ?.copyWith(color: theme.colorScheme.surface),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (uc.state.user != null)
                    UserView(user: uc.state.user!, textStyle: theme.textTheme.headline6
                        ?.copyWith(color: theme.colorScheme.surface), avatarRadius: 20, outerPadding:const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),),

                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 40),
                  child: Text(
                    pc.state.post.content,
                    style: theme.textTheme.headline6?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.thumb_up,
                          color: theme.colorScheme.onSurface,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${pc.state.post.likes}",
                          style: theme.textTheme.headline6
                              ?.copyWith(color: theme.colorScheme.onSurface),
                        )
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.remove_red_eye,
                          color: theme.colorScheme.onSurface,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${pc.state.post.hits}",
                          style: theme.textTheme.headline6
                              ?.copyWith(color: theme.colorScheme.onSurface),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          const Divider(thickness: 2,),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for(var c in cc.state.comments)
                BlocProvider(
                  create: (ctx) => UserCubit(
                      repo: Provider.of<Injector>(context, listen: false).get())
                    ..loadUser(c.userId),
                  child: BlocBuilder<UserCubit, UserState>(builder: (ctx, state)=>
                      state.user==null? const CircularProgressIndicator():
                      CommentView(comment: c, user: state.user!,)),
                )
            ],
          )
        ],
      ),
    );
  }
}
