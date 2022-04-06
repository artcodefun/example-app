import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:test_app/components/PostView.dart';
import 'package:test_app/components/UserView.dart';
import 'package:test_app/generated/l10n.dart';
import 'package:test_app/helpers/AppModule.dart';

import 'package:test_app/main.dart' as app;
import 'package:test_app/main.dart';
import 'package:test_app/pages/auth/LoginPage.dart';
import 'package:test_app/pages/home/HomePage.dart';
import 'package:test_app/pages/home/PostDetailsPage.dart';
import 'package:test_app/pages/home/UserPage.dart';

Future<void> pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 60),
}) async {
  bool timerDone = false;
  final timer =
      Timer(timeout, () => throw TimeoutException("Pump until has timed out"));
  while (timerDone != true) {
    await tester.pump();

    final found = tester.any(finder);
    if (found) {
      timerDone = true;
    }
  }
  timer.cancel();
}

main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('app test', (WidgetTester tester) async {

      await app.main();

      await tester.pumpAndSettle();

      expect(find.byType(LoginPage), findsOneWidget,
          reason: "user should see login page");

      Finder textFields = find.byType(TextField);

      expect(textFields, findsNWidgets(2),
          reason: "should find two text fields (login & password)");

      Finder loginField = find.byType(TextField).at(0);
      Finder passField = find.byType(TextField).at(1);
      Finder loginButton = find.text(S.current.log_in);

      await tester.tap(loginField);

      await tester.enterText(loginField, "loginExample");

      await tester.dragUntilVisible(loginField, loginButton, Offset(0, -10));

      await tester.tap(passField);

      await tester.enterText(passField, "passwordExample");

      await tester.tap(loginButton);

      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget,
          reason: "should be on HomePage if authentication was successful");

      Finder posts = find.byType(PostView);

      await pumpUntilFound(tester, posts);

      await tester.tap(posts.first);

      await tester.pumpAndSettle();

      expect(find.byType(PostDetailsPage), findsOneWidget,
          reason: "should be on PostDetailsPage after tap on PostView");

      Finder userView = find.byType(UserView);

      var user = tester.widget<UserView>(userView).user;

      await tester.tap(userView);

      await tester.pumpAndSettle();

      expect(find.byType(UserPage), findsOneWidget,
          reason: "should be on UserPage after tap on UserView");

      expect(find.text(user.email), findsOneWidget,
          reason: "user's email should be visible on UserPage");

      await tester.tap(find.byIcon(Icons.arrow_back).last);

      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.arrow_back).last);

      await tester.pumpAndSettle();

      Finder menu = find.byIcon(Icons.menu);
      expect(menu, findsOneWidget,
          reason: "drawer's menu icon should be visible on HomePage");

      await tester.tap(menu);

      await tester.pumpAndSettle();

      Finder logOut = find.text(S.current.log_out);

      expect(logOut, findsOneWidget,
          reason: "menu should contain log out option");

      await tester.tap(logOut);

      await tester.pumpAndSettle();

      expect(find.byType(LoginPage), findsOneWidget,
          reason: "should be on LoginPage after log out");
    });
  });
}
