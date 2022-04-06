import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/bloc/auth/AuthCubit.dart';
import 'package:test_app/components/KeyboardAwareScrollView.dart';
import 'package:test_app/components/LoginForm.dart';
import 'package:test_app/generated/l10n.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(S.of(context).app_title),
        ),
        body: KeyboardAwareScrollView(
          child: Column(
            children: [
              Flexible(child: Image.asset("assets/images/enter.png", fit: BoxFit.fitWidth)),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 60),
                child: Text(
                  S.of(context).login_hello,
                  style: theme.textTheme.headline3
                      ?.copyWith(color: theme.colorScheme.primary),
                ),
              ),
              Flexible(child: LoginForm(
                onLoginAttempt: (email, password) async {
                  var error =
                      await Provider.of<AuthCubit>(context, listen: false)
                          .logIn(email, password);
                  if (error != null) {
                    return error;
                  }
                },
              )),
            ],
          ),
        ));
  }
}
