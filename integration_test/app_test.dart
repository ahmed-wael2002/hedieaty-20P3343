// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lecture_code/features/homepage/presentation/widgets/speeddial_widget.dart';
// import 'package:lecture_code/features/homepage/presentation/pages/home_page.dart';
import 'package:lecture_code/main.dart' as app;
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

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
      await tester.tap(find.byType(ElevatedButton));
      print('Login Page Testing Completed');
      await tester.pumpAndSettle(const Duration(seconds: 5));


      /***********************************************************
       * Testing going to event page and creating an event
       ************************************************************/
      print('Running Test: Event Page Testing');

      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(find.byType(FlashyTabBar), findsNWidgets(4));
      expect(find.byType(SpeeddialButton), findsOneWidget);

      await tester.tap(find.byType(SpeedDial));
      await tester.tap(find.byType(FlashyTabBar).at(2));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('speedDial')));
      await tester.tap(find.byType(SpeeddialButton));
      await tester.pumpAndSettle(const Duration(seconds: 5));

    }
  );
  });
}
