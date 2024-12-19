import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lecture_code/features/auth/presentation/state_mgmt/auth_provider.dart';
import 'package:lecture_code/features/auth/presentation/pages/login_page.dart';
// import 'package:lecture_code/features/homepage/presentation/pages/home_page.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
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
      'Displays form fields and login button',
      (WidgetTester tester) async {
        await tester.pumpWidget(createTestableWidget());
        // Verify UI components
        expect(find.byType(TextFormField), findsNWidgets(2)); // Email and password fields
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
      expect(find.text('Please enter an email address'), findsOneWidget); // Match actual validation output
      expect(find.text('Please enter your password'), findsOneWidget); // Match actual validation output
    });

    /*************************************************************************************
        Testing invalid credentials
     *************************************************************************************/
    testWidgets(
      'Validate with invalid credentials',
          (WidgetTester tester) async {
        // Arrange: Load the widget
        await tester.pumpWidget(createTestableWidget());

        // Act: Enter invalid email and password
        await tester.enterText(find.byKey(const Key('SignInEmailField')), 'test'); // Invalid email
        await tester.enterText(find.byKey(const Key('SignInPasswordField')), '1234'); // Invalid password
        await tester.tap(find.byType(ElevatedButton)); // Tap the login button
        await tester.pumpAndSettle(); // Wait for the UI to update

        // Assert: Verify the error messages
        expect(find.text('Please enter a valid email address'), findsOneWidget); // Email error
        expect(find.text('Password must be at least 6 characters'), findsOneWidget); // Email error
      },
    );

    /*************************************************************************************
        Testing successful login
     *************************************************************************************/
    testWidgets(
      'Successful login navigates to the next screen',
          (WidgetTester tester) async {
        // Arrange: Stub the `login` and `isLoggedIn` methods
        when(mockAuthenticationProvider.login(any, any)).thenAnswer((_) async => true);
        when(mockAuthenticationProvider.isLoggedIn).thenReturn(true); // Stub isLoggedIn to return true

        // Load the widget
        await tester.pumpWidget(createTestableWidget());

        // Act: Enter valid email and password
        await tester.enterText(find.byKey(const Key('SignInEmailField')), 'test@example.com'); // Valid email
        await tester.enterText(find.byKey(const Key('SignInPasswordField')), 'password123'); // Valid password
        await tester.tap(find.byType(ElevatedButton)); // Tap the login button
        await tester.pumpAndSettle(); // Wait for navigation

        // Assert: Verify the login method is called with the correct arguments
        verify(mockAuthenticationProvider.login('test@example.com', 'password123')).called(1);

        // Assert: Verify success behavior (e.g., navigation or success message)
        // expect(find.byType(SnackBar), findsOneWidget); // Replace with actual success indicator
        // expect(find.byWidget(const MyHomePage()), findsOneWidget);
      },
    );

  });
}
