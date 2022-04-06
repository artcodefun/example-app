import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/bloc/auth/AuthCubit.dart';
import 'package:test_app/components/KeyboardAwareScrollView.dart';
import 'package:test_app/components/SignUpForm.dart';
import 'package:test_app/generated/l10n.dart';
import 'package:test_app/helpers/NavigationInfo.dart';
import 'package:test_app/pages/auth/dialogs/SignUpDialog.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

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
              Flexible(child: Image.asset("assets/images/welcome.png", fit: BoxFit.fitWidth)),
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 60),
                child: Text(
                  S.of(context).signup_hello,
                  style: theme.textTheme.headline3
                      ?.copyWith(color: theme.colorScheme.primary),
                ),
              ),
              Flexible(child: SignUpForm(
                onSignUpAttempt: (String email, String password) async {
                  var error =
                      await Provider.of<AuthCubit>(context, listen: false)
                          .signUp(email, password);
                  if (error != null) {
                    return error;
                  }

                  await showDialog(context: context, builder: (_)=>SignUpDialog(login: email), );

                  Navigator.of(context).pushReplacementNamed(NavigationInfo.login);

                },
              )),
            ],
          ),
        ));
  }
}
