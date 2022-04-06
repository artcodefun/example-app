// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Test App`
  String get app_title {
    return Intl.message(
      'Test App',
      name: 'app_title',
      desc: '',
      args: [],
    );
  }

  /// `email/nickname`
  String get login_field {
    return Intl.message(
      'email/nickname',
      name: 'login_field',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get password_field {
    return Intl.message(
      'password',
      name: 'password_field',
      desc: '',
      args: [],
    );
  }

  /// `Hello there!`
  String get login_hello {
    return Intl.message(
      'Hello there!',
      name: 'login_hello',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get log_in {
    return Intl.message(
      'Log in',
      name: 'log_in',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get sign_up {
    return Intl.message(
      'Sign up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `New here?`
  String get new_here {
    return Intl.message(
      'New here?',
      name: 'new_here',
      desc: '',
      args: [],
    );
  }

  /// `Welcome!`
  String get signup_hello {
    return Intl.message(
      'Welcome!',
      name: 'signup_hello',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get already_have_account {
    return Intl.message(
      'Already have an account?',
      name: 'already_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect login`
  String get error_incorrect_login {
    return Intl.message(
      'Incorrect login',
      name: 'error_incorrect_login',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password`
  String get error_incorrect_pass {
    return Intl.message(
      'Incorrect password',
      name: 'error_incorrect_pass',
      desc: '',
      args: [],
    );
  }

  /// `Wow!`
  String get wow {
    return Intl.message(
      'Wow!',
      name: 'wow',
      desc: '',
      args: [],
    );
  }

  /// `Thanks for joining us!!!`
  String get thanks_for_joining {
    return Intl.message(
      'Thanks for joining us!!!',
      name: 'thanks_for_joining',
      desc: '',
      args: [],
    );
  }

  /// `You can now log in and start using the app, *.`
  String get u_can_login {
    return Intl.message(
      'You can now log in and start using the app, *.',
      name: 'u_can_login',
      desc: '',
      args: [],
    );
  }

  /// `Post Details`
  String get post_details {
    return Intl.message(
      'Post Details',
      name: 'post_details',
      desc: '',
      args: [],
    );
  }

  /// `User Details`
  String get user_details {
    return Intl.message(
      'User Details',
      name: 'user_details',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get last_name {
    return Intl.message(
      'Last Name',
      name: 'last_name',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Website`
  String get website {
    return Intl.message(
      'Website',
      name: 'website',
      desc: '',
      args: [],
    );
  }

  /// `Latest posts`
  String get latest_posts {
    return Intl.message(
      'Latest posts',
      name: 'latest_posts',
      desc: '',
      args: [],
    );
  }

  /// `Hello!!!`
  String get drawer_title {
    return Intl.message(
      'Hello!!!',
      name: 'drawer_title',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get log_out {
    return Intl.message(
      'Log Out',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `Do Something`
  String get do_something {
    return Intl.message(
      'Do Something',
      name: 'do_something',
      desc: '',
      args: [],
    );
  }

  /// `Doing Something`
  String get doing_something {
    return Intl.message(
      'Doing Something',
      name: 'doing_something',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
