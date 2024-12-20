// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
// import 'package:lecture_code/features/homepage/presentation/widgets/speeddial_widget.dart';
// import 'package:lecture_code/features/homepage/presentation/pages/home_page.dart';
import 'package:lecture_code/main.dart' as app;
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Test A single complete user scenario', (){

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });

  testWidgets(
    'Main app widget testing',
    (WidgetTester tester) async {
      // await Firebase.initializeApp();
      app.main();
      /***********************************************************
       * Testing signIn to SignUp
       ************************************************************/
      print('Running Test: Login to Sign Page');
      await tester.pumpAndSettle(const Duration(seconds: 5));
      await tester.tap(find.byKey(const Key('RedirectToSignUp')));


      /***********************************************************
       * Sign up Page Testing
       ************************************************************/
      print('Running Test: Sign Up Page Testing');
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final signUpNameField = find.byKey(const Key('SignUpNameField'));
      final signUpEmailField = find.byKey(const Key('SignUpEmailField'));
      final signUpPasswordField = find.byKey(const Key('SignUpPasswordField'));
      final signUpPhoneField = find.byKey(const Key('SignUpPhoneField'));
      final signUpButton = find.byKey(const Key('SignUpButton'));

      // Verify that the fields are present on the SignupPage
      expect(signUpNameField, findsOneWidget);
      expect(signUpEmailField, findsOneWidget);
      expect(signUpPasswordField, findsOneWidget);
      expect(signUpPhoneField, findsOneWidget);
      expect(signUpButton, findsOneWidget);

      await tester.enterText(signUpNameField, 'Ahmed');
      await tester.enterText(signUpEmailField, 'test@test.com');

      await tester.pumpAndSettle();
      await tester.ensureVisible(signUpButton);
      await tester.pumpAndSettle();

      await tester.enterText(signUpPasswordField, '123456');
      await tester.enterText(signUpPhoneField, '0123456789');
      await tester.pumpAndSettle(const Duration(seconds: 1));

      await tester.tap(find.byType(ElevatedButton));
      print('Sign Up Page Testing Completed');
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // await tester.tap(find.byType(ElevatedButton));
      // print('Login Page Testing Completed');
      // await tester.pumpAndSettle(const Duration(seconds: 5));


      /***********************************************************
       * Login Page Testing
       ************************************************************/
      print('Running Test: Login Page Testing');
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
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.tap(signInButton);
      print('Login Page Testing Completed');
      await tester.pumpAndSettle(const Duration(seconds: 5));

      /***********************************************************
       * Testing going to event page and creating an event
       ************************************************************/
      // print('Running Test: Event Page Testing');
      //
      // await tester.pumpAndSettle(const Duration(seconds: 5));
      //
      // expect(find.byType(FlashyTabBar), findsNWidgets(4));
      // expect(find.byType(SpeeddialButton), findsOneWidget);
      //
      // await tester.tap(find.byType(SpeedDial));
      // await tester.tap(find.byType(FlashyTabBar).at(2));
      // await tester.pumpAndSettle();
      //
      // await tester.tap(find.byKey(const Key('speedDial')));
      // await tester.tap(find.byType(SpeeddialButton));
      // await tester.pumpAndSettle(const Duration(seconds: 5));

    }
  );
  });
}
