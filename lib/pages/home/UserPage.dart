import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:provider/provider.dart';
import 'package:test_app/bloc/post/PostListCubit.dart';
import 'package:test_app/bloc/post/UserPostListCubit.dart';
import 'package:test_app/bloc/user/UserCubit.dart';
import 'package:test_app/bloc/user/UserState.dart';
import 'package:test_app/components/SafeScroll.dart';
import 'package:test_app/components/SliverPostList.dart';
import 'package:test_app/generated/l10n.dart';
import 'package:test_app/models/User.dart';

import '../../bloc/category/CategoriesCubit.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).user_details),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (ctx) => UserCubit(
                  repo: Provider.of<Injector>(context, listen: false).get(),
                  initialUser: user)),
          BlocProvider<PostListCubit>(
              create: (ctx) => UserPostListCubit(
                    repo: Provider.of<Injector>(context, listen: false).get(),
                    user: user,
                  )..loadLast()),
          BlocProvider(
              create: (ctx) => CategoriesCubit(
                  repo: Provider.of<Injector>(context, listen: false).get())
                ..loadAllCategories()),
        ],
        child: BlocBuilder<UserCubit, UserState>(
          builder: (ctx, state) {
            User u = state.user ?? user;
            var s = S.of(context);
            return ScrollConfiguration(
              behavior: CleanBehavior(),
              child: CustomScrollView(
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      collapsedHeight: null,
                      toolbarHeight: 0,
                      expandedHeight: 300,
                      backgroundColor: theme.colorScheme.primaryVariant,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: theme.colorScheme.surface),
                              padding: const EdgeInsets.all(3),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  u.avatar,
                                ),
                                backgroundColor: theme.colorScheme.primaryVariant,
                                radius: 90,
                              ),
                            ),
                            Text(
                              u.username,
                              style: theme.textTheme.headline4?.copyWith(
                                  color: theme.colorScheme.onPrimary),
                            )
                          ],
                        ),
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      Container(
                        color: theme.colorScheme.surface,
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 30),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            [s.name, u.firstName],
                            [s.last_name, u.lastName],
                            [s.gender, u.gender],
                            [s.age, u.age],
                            [s.email, u.email],
                            [s.phone, u.phone],
                            [s.website, u.website],
                          ]
                              .map((e) => Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      children: [
                                        Text(
                                          e[0].toString() + " : ",
                                          style: theme.textTheme.headline6
                                              ?.copyWith(
                                                  color: theme
                                                      .colorScheme.primary),
                                        ),
                                        Expanded(
                                          child: SelectableText(
                                            e[1].toString(),
                                            style: theme.textTheme.headline6
                                                ?.copyWith(
                                                    color: theme
                                                        .colorScheme.onSurface),
                                          ),
                                        )
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Text(

                          s.latest_posts + " : ",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headline5?.copyWith(color: theme.colorScheme.onSurface),
                        ),
                      )
                    ])),
                    const SliverPostList()
                  ]),
            );
          },
        ),
      ),
    );
  }
}
