import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lecture_code/features/auth/presentation/pages/signup_page.dart';
import 'package:lecture_code/features/auth/presentation/state_mgmt/auth_provider.dart';
import 'package:lecture_code/features/auth/presentation/pages/login_page.dart';
import 'package:lecture_code/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:lecture_code/features/notification/data/firebase_messaging/firebase_messaging_api.dart';
// import 'package:lecture_code/features/homepage/presentation/pages/home_page.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'app_test_mocks.dart';

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
        child: MaterialApp(
            home: LoginPage()
        ),
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
        await tester.enterText(find.byKey(const Key('SignInEmailField')), 'integration_test'); // Invalid email
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
        await tester.enterText(find.byKey(const Key('SignInEmailField')), 'integration_test@example.com'); // Valid email
        await tester.enterText(find.byKey(const Key('SignInPasswordField')), 'password123'); // Valid password
        await tester.tap(find.byType(ElevatedButton)); // Tap the login button
        await tester.pumpAndSettle(); // Wait for navigation

        // Assert: Verify the login method is called with the correct arguments
        verify(mockAuthenticationProvider.login('integration_test@example.com', 'password123')).called(1);

        // Assert: Verify success behavior (e.g., navigation or success message)
        // expect(find.byType(SnackBar), findsOneWidget); // Replace with actual success indicator
        // expect(find.byWidget(const MyHomePage()), findsOneWidget);
      },
    );
  });


  // SignUp Code
  group(
    'Sign up Page UI Test',
    () {

    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      await FirebaseAPI().initNotification();
    });

    /*************************************************************************************
        Testing sign up page UI components
     *************************************************************************************/
    testWidgets('First sign up test', (WidgetTester tester) async {
      // Dependency Injection
      TestWidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      await FirebaseAPI().initNotification();

      // Actual Testing
      await tester.pumpWidget(MaterialApp(home: SignupPage()));

      // Ensure only 2 TextFormField widgets exist within the SignupPage
      final textFormFields = find.descendant(
        of: find.byType(SignupPage),
        matching: find.byType(CustomFormTextField),
      );
      expect(textFormFields, findsNWidgets(3));

      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    /*************************************************************************************
        Testing sign up attempt with empty fields
     *************************************************************************************/
    testWidgets('LoginPage navigate to SignupPage and enter text in fields', (WidgetTester tester) async {
      // Build the LoginPage widget with the necessary providers
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (_) => AuthenticationProvider(),
            child: LoginPage(),
          ),
        ),
      );

      // Find the 'Sign up' text and tap it to navigate to the SignupPage
      final signUpText = find.byKey(const Key('RedirectToSignUp'));
      await tester.tap(signUpText);
      await tester.pumpAndSettle(); // Wait for navigation to complete

      // Verify that the SignupPage has been loaded
      expect(find.byType(SignupPage), findsOneWidget);

      // Find the input fields in the SignupPage
      final nameField = find.byKey(const Key('SignUpNameField'));
      final emailField = find.byKey(const Key('SignUpEmailField'));
      final phoneField = find.byKey(const Key('SignUpPhoneField'));
      final passwordField = find.byKey(const Key('SignUpPasswordField'));

      // Verify that the fields are present on the SignupPage
      expect(nameField, findsOneWidget);
      expect(emailField, findsOneWidget);
      expect(phoneField, findsOneWidget);
      expect(passwordField, findsOneWidget);

      // Enter text into the fields
      await tester.enterText(nameField, 'John Doe');
      await tester.enterText(emailField, 'john.doe@example.com');
      await tester.enterText(phoneField, '1234567890');
      await tester.enterText(passwordField, 'securepassword123');

      // Verify that the text has been entered correctly
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('john.doe@example.com'), findsOneWidget);
      expect(find.text('1234567890'), findsOneWidget);
      expect(find.text('securepassword123'), findsOneWidget);
    });
  });
}
