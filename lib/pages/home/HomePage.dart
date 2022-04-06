import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:provider/provider.dart';
import 'package:test_app/bloc/auth/AuthCubit.dart';
import 'package:test_app/bloc/category/CategoriesCubit.dart';
import 'package:test_app/bloc/post/PostListCubit.dart';
import 'package:test_app/components/PostList.dart';
import 'package:test_app/generated/l10n.dart';
import 'package:test_app/pages/home/dialogs/DoingSomethingDialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
                child: Center(
                  child: Text(
                    S.of(context).drawer_title,
                    style: theme.textTheme.headline4
                        ?.copyWith(color: theme.colorScheme.onPrimary),
                  ),
                ),
                decoration: BoxDecoration(color: theme.colorScheme.primary)),
            Image.asset(
              "assets/images/menu.png",
              fit: BoxFit.fitWidth,
            ),
            ListTile(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) => const DoingSomethingDialog());
              },
              leading: Text(
                "🙀",
                style: theme.textTheme.headline6,
              ),
              minLeadingWidth: 0,
              title: Row(
                children: [
                  Expanded(
                      child: Text(
                    S.of(context).do_something + " 1",
                    style: theme.textTheme.headline6,
                  )),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) => const DoingSomethingDialog());
              },
              leading: Text(
                "🤖",
                style: theme.textTheme.headline6,
              ),
              minLeadingWidth: 0,
              title: Row(
                children: [
                  Expanded(
                      child: Text(
                    S.of(context).do_something + " 2",
                    style: theme.textTheme.headline6,
                  )),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                Provider.of<AuthCubit>(context, listen: false).logOut();
              },
              leading: Text(
                "👋",
                style: theme.textTheme.headline6,
              ),
              minLeadingWidth: 0,
              title: Row(
                children: [
                  Expanded(
                      child: Text(
                    S.of(context).log_out,
                    style: theme.textTheme.headline6,
                  )),
                ],
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(S.of(context).app_title),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (ctx) => CategoriesCubit(
                  repo: Provider.of<Injector>(context, listen: false).get())
                ..loadAllCategories()),
          BlocProvider(
              create: (ctx) => PostListCubit(
                  repo: Provider.of<Injector>(context, listen: false).get())
                ..loadLast())
        ],
        child: const PostList(),
      ),
    );
  }
}
