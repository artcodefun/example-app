import 'package:flutter/material.dart';
import 'package:test_app/generated/l10n.dart';
import 'package:test_app/helpers/NavigationInfo.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key, required this.onSignUpAttempt}) : super(key: key);
  final Future<String?> Function(String login, String password) onSignUpAttempt;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
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
                  onPressed: onSignUpButtonTap,
                  child: Text(S.of(context).sign_up,
                      style: theme.textTheme.headline5
                          ?.copyWith(color: theme.colorScheme.surface)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).already_have_account,
                    style: theme.textTheme.bodyText2?.copyWith(
                        color: theme.textTheme.bodyText2?.color?.withOpacity(0.5)),
                  ),
                  TextButton(
                      onPressed: () {Navigator.of(context).pushReplacementNamed(NavigationInfo.login);},
                      child: Text(
                        S.of(context).log_in,
                        style: theme.textTheme.bodyText2?.copyWith(
                            decoration: TextDecoration.underline,
                            color:
                            theme.textTheme.bodyText2?.color?.withOpacity(0.5)),
                      )),
                ],
              ),
              const Spacer()
            ],
          ),
        ));
  }

  onSignUpButtonTap() async {
    if (_formKey.currentState?.validate() == true) {
      await widget.onSignUpAttempt(
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
