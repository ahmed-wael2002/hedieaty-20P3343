import 'package:flutter/material.dart';
import 'package:lecture_code/features/auth/presentation/state_mgmt/validator_functions.dart';
import 'package:lecture_code/features/auth/presentation/widgets/custom_password_field.dart';
import 'package:lecture_code/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../state_mgmt/auth_provider.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController(); // Fixed spelling
  final _formKey = GlobalKey<FormState>();

  void _signUpFn(BuildContext context, GlobalKey<FormState> formKey, String name, String email, String password, String phoneNumber) async {
    final authProvider = Provider.of<AuthenticationProvider>(context, listen: false); // Use listen: false to avoid rebuild issues

    if (formKey.currentState!.validate()) {
      await authProvider.register(name, email, password, phoneNumber);
      _notify(authProvider.isSignedUp, context);
      if (authProvider.isSignedUp) {
        Navigator.pop(context);
      }
    }
  }

  void _notify(bool result, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result ? 'Signed Up Successfully' : 'Sign Up Failed'),
        backgroundColor: result ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthenticationProvider>(
      create: (_) => AuthenticationProvider(),
      child: Builder(builder: (context) {
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Sign Up', style: Theme.of(context).textTheme.headlineLarge),

                  const SizedBox(height: 20),

                  CustomFormTextField(
                    controller: _nameController,
                    validator: nameValidator,
                    labelText: 'User name',
                    hintText: 'Enter your username',
                    inputType: keyboardTypes['username'],
                  ),

                  const SizedBox(height: 20),

                  CustomFormTextField(
                    controller: _emailController,
                    validator: emailValidator,
                    labelText: 'E-mail',
                    hintText: 'Enter your email address',
                    inputType: keyboardTypes['email'],
                  ),

                  const SizedBox(height: 20),

                  CustomFormTextField(
                    controller: _phoneController,
                    validator: nameValidator,
                    labelText: 'Phone Number',
                    hintText: 'Enter your phone number',
                    inputType: keyboardTypes['username'],
                  ),

                  const SizedBox(height: 20),

                  CustomPasswordField(
                    controller: _passwordController,
                    validator: passwordValidator,
                    labelText: 'Password',
                    hintText: 'Enter a valid password',
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () => _signUpFn(
                      context,
                      _formKey,
                      _nameController.text,
                      _emailController.text,
                      _passwordController.text,
                      _phoneController.text
                    ), // Pass function reference properly
                    child: const Text('Sign up'),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
