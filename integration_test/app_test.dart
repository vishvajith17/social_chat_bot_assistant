import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:social_chat_bot_assistant/components/rounded_button.dart';
import 'package:social_chat_bot_assistant/screens/Login/components/body.dart';
import 'package:social_chat_bot_assistant/screens/Login/login_screen.dart';
import 'package:social_chat_bot_assistant/main.dart' as app;

import 'package:flutter/material.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
  as IntegrationTestWidgetsFlutterBinding;
  testWidgets("Verify Login screen", (WidgetTester tester) async {
    app.main();
    await binding.traceAction(() async {
      await tester.pumpAndSettle();
      expect(
          find.byWidgetPredicate((Widget widget) =>
          widget is Text && widget.data.startsWith('Login')),
          findsOneWidget);
      final loginFinder = find.byWidgetPredicate((widget) =>
      widget is RoundedButton;
      expect(loginFinder, findsOneWidget);
      await tester.tap(loginFinder);
      await tester.pumpAndSettle();
      final emailField = find.byKey(Key("email-field"));
      expect(emailField, findsOneWidget);
      await tester.tap(emailField);
      await tester.enterText(emailField, "test2@testmail.com");
      final passwordField = find.byKey(Key("password-field"));
      expect(passwordField, findsOneWidget);
      await tester.tap(passwordField);
      await tester.enterText(passwordField, "testtest");
      await tester.pump();
      final loginButton = find.byKey(Key("login-button"));
      expect(loginButton, findsOneWidget);
      await tester.tap(loginButton);
      await tester.pumpAndSettle(Duration(seconds: 10));

      expect(find.byWidgetPredicate((widget) => widget is IntroPage),findsOneWidget);
    });
  });
}