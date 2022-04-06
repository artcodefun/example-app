import 'package:flutter/material.dart';
import 'package:test_app/helpers/NavigationInfo.dart';
import 'package:test_app/models/User.dart';
import 'package:test_app/pages/home/UserPage.dart';

class UserView extends StatelessWidget {
  const UserView(
      {Key? key,
      required this.user,
      this.outerPadding = EdgeInsets.zero,
      required this.textStyle,
      this.avatarRadius = 20})
      : super(key: key);
  final User user;
  final EdgeInsets outerPadding;
  final TextStyle? textStyle;
  final double avatarRadius;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) =>
              UserPage(user: user,))),
      child: Container(
        color: Colors.transparent,
        padding: outerPadding,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: theme.colorScheme.primary),
                padding: const EdgeInsets.all(3),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    user.avatar,
                  ),
                  backgroundColor: theme.colorScheme.onSurface,
                  radius: avatarRadius,
                ),
              ),
            ),
            Text(user.username, style: textStyle)
          ],
        ),
      ),
    );
  }
}
