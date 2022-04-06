import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/bloc/user/UserCubit.dart';
import 'package:test_app/components/UserView.dart';
import 'package:test_app/models/Comment.dart';
import 'package:test_app/models/User.dart';

class CommentView extends StatelessWidget {
  const CommentView({Key? key, required this.comment, required this.user})
      : super(key: key);

  final Comment comment;
  final User user;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border.all(color: theme.colorScheme.primaryVariant),
          borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UserView(
            user: user,
            textStyle: theme.textTheme.bodyText1
                ?.copyWith(color: theme.colorScheme.onSurface),
            avatarRadius: 15,
            outerPadding: const EdgeInsets.only(top: 10, bottom: 20),
          ),
          Text(comment.body),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Row(
              children: [
                Icon(
                  Icons.thumb_up,
                  color: theme.colorScheme.onSurface,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "${comment.likes}",
                  style: theme.textTheme.headline6
                      ?.copyWith(color: theme.colorScheme.onSurface),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
