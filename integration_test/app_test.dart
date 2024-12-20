// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
// import 'package:lecture_code/features/homepage/presentation/pages/home_page.dart';
import 'package:lecture_code/main.dart' as app;

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Test group', (){

  testWidgets(
    'Main app widget testing',

    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final emailField = find.byKey(const Key('SignInEmailField'));
      final passwordField = find.byKey(const Key('SignInPasswordField'));
      final signInButton = find.byKey(const Key('SignInPasswordField'));

      // Verify that the fields are present on the SignupPage
      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(signInButton, findsOneWidget);

      await tester.enterText(emailField, 'ahmed@gmail.com');
      await tester.enterText(passwordField, '123456');
      await tester.tap(signInButton);

      await tester.pumpAndSettle(const Duration(seconds: 5));
    }
  );
  });
}
