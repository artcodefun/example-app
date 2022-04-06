import 'package:flutter/material.dart';
import 'package:test_app/generated/l10n.dart';

class SignUpDialog extends StatelessWidget {
  const SignUpDialog({Key? key, required this.login}) : super(key: key);
  final String login;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Dialog(shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0))),
    insetPadding: const EdgeInsets.symmetric(horizontal: 15,),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(mainAxisSize : MainAxisSize.min,  children: [
        Text(
          S.of(context).wow,
          style: theme.textTheme.headline3
              ?.copyWith(color: theme.colorScheme.primary),
        ),
        Image.asset("assets/images/join.png", fit: BoxFit.fitWidth),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            S.of(context).thanks_for_joining,
            textAlign: TextAlign.center,
            style: theme.textTheme.headline4
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Text(
            S.of(context).u_can_login.replaceAll("*", login),
            textAlign: TextAlign.center,
            style: theme.textTheme.headline6?.copyWith(color: theme.colorScheme.primary),
          ),
        ),
      ],),
    ),);
  }
}
