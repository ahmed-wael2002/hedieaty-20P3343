import 'package:flutter/material.dart';
import 'package:lecture_code/features/auth/presentation/pages/signup_page.dart';
import 'package:provider/provider.dart';
import '../state_mgmt/auth_provider.dart';
import '../state_mgmt/validator_functions.dart';
import '../widgets/custom_password_field.dart';
import '../widgets/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthenticationProvider>(context, listen:true);

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image.asset('assets/images/header.jpg'),
              Text(
                'Login',
                style: Theme.of(context).textTheme.headlineLarge,
              ),

              const SizedBox(height: 20),

              CustomFormTextField(
                key: const Key('SignInEmailField'),
                controller: _emailController,
                validator: emailValidator,
                labelText: 'Email',
                hintText: 'Enter your email',
                inputType: keyboardTypes['email'],
              ),

              const SizedBox(height: 20),

              CustomPasswordField(
                key: const Key('SignInPasswordField'),
                controller: _passwordController,
                validator: passwordValidator,
                labelText: 'Password',
                hintText: 'Enter your password',
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                key: const Key('signInButton'),
                onPressed: ()=>_loginButtonFn(context, _formKey, loginProvider, _emailController.text, _passwordController.text),
                child: const Text('Login'),
              ),

              const SizedBox(height: 20),

              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account? '),
                  GestureDetector(
                    onTap: ()=>Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=>SignupPage())
                    ),
                    child: const Text(
                        'Sign up',
                        style: TextStyle(color: Colors.blue),
                      )
                    )
                  ],
                ),

            ],
          ),
        ),
      ),
    );
  }
}

_loginButtonFn(context, formKey, loginProvider, email, password) async{
  if(formKey.currentState!.validate()){
    await loginProvider.login(email, password);
    if(loginProvider.isLoggedIn == false){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: loginProvider.isLoggedIn ? const Text('Logged in successfully') : const Text('Logged in failed'),
            backgroundColor: loginProvider.isLoggedIn ? Colors.green : Colors.red,
          )
      );
    }
  }
}

