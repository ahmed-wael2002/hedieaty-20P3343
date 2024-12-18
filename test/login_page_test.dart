import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lecture_code/features/auth/presentation/state_mgmt/auth_provider.dart';
import 'package:lecture_code/features/auth/presentation/pages/login_page.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';
import 'login_page_test.mocks.dart';

@GenerateMocks([AuthenticationProvider])

void main() async {
  group('LoginPage Tests', ()
  {
    late MockAuthenticationProvider mockAuthenticationProvider;

    setUp(() {
      mockAuthenticationProvider = MockAuthenticationProvider();
    });

    Widget createTestableWidget() {
      return ChangeNotifierProvider<AuthenticationProvider>(
        create: (_) => mockAuthenticationProvider,
        child: MaterialApp(home: LoginPage()),
      );
    }

    /*
    Testing existing UI components in Login Page
     */
    testWidgets(
        'Displays form fields and login button', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());
      // Verify UI components
      expect(find.byType(TextFormField),
          findsNWidgets(2)); // Email and password fields
      expect(find.byType(ElevatedButton), findsOneWidget);
    });


    /*************************************************************************************
        Testing login attempt with empty fields
     *************************************************************************************/
    testWidgets('Validates empty form fields', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());

      // Trigger validation
      await tester.tap(find.byType(ElevatedButton)); // Tap the login button
      await tester.pumpAndSettle(); // Rebuild the widget tree

      // Verify error messages
      expect(find.text('Please enter an email address'),
          findsOneWidget); // Match actual validation output
      expect(find.text('Please enter your password'),
          findsOneWidget); // Match actual validation output
    });
  });
}
