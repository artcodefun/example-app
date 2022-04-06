import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/bloc/auth/AuthCubit.dart';
import 'package:test_app/generated/l10n.dart';
import 'package:test_app/helpers/NavigationInfo.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key, required this.onLoginAttempt}) : super(key: key);
  final Future<String?> Function(String login, String password) onLoginAttempt;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController loginController, passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    loginController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: loginController,
                validator: checkLogin,
                decoration: InputDecoration(
                    hintText: S.of(context).login_field,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none),
                    prefixIcon: const Icon(Icons.email),
                    filled: true),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: true,
                controller: passwordController,
                validator: checkPass,
                decoration: InputDecoration(
                    hintText: S.of(context).password_field,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none),
                    prefixIcon: const Icon(Icons.password),
                    filled: true),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  onPressed: onLoginButtonTap,
                  child: Text(S.of(context).log_in,
                      style: theme.textTheme.headline5
                          ?.copyWith(color: theme.colorScheme.surface)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).new_here,
                    style: theme.textTheme.bodyText2?.copyWith(
                        color:
                            theme.textTheme.bodyText2?.color?.withOpacity(0.5)),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(NavigationInfo.signup);
                      },
                      child: Text(
                        S.of(context).sign_up,
                        style: theme.textTheme.bodyText2?.copyWith(
                            decoration: TextDecoration.underline,
                            color: theme.textTheme.bodyText2?.color
                                ?.withOpacity(0.5)),
                      )),
                ],
              ),
              const Spacer()
            ],
          ),
        ));
  }

  onLoginButtonTap() async {
    if (_formKey.currentState?.validate() == true) {
      await widget.onLoginAttempt(
          loginController.text, passwordController.text);
    }
  }

  String? checkLogin(String? s) {
    if (s == null) return S.of(context).error_incorrect_login;

    if (s.length < 5) return S.of(context).error_incorrect_login;
  }

  String? checkPass(String? s) {
    if (s == null) return S.of(context).error_incorrect_pass;

    if (s.length < 5) return S.of(context).error_incorrect_pass;
  }
}
