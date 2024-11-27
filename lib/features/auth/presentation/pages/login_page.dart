import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state_mgmt/login_provider.dart';
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
    final loginProvider = Provider.of<LoginProvider>(context, listen:true);

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

              CustomFormTextField(
                controller: _emailController,
                validator: emailValidator,
                labelText: 'Email',
                hintText: 'Enter your email',
                inputType: keyboardTypes['email'],
              ),

              const SizedBox(height: 10),

              CustomPasswordField(
                controller: _passwordController,
                validator: passwordValidator,
                labelText: 'Password',
                hintText: 'Enter your password',
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () async{
                  if(_formKey.currentState!.validate()){
                    await loginProvider.login(_emailController.text, _passwordController.text);
                    if(loginProvider.isLoggedIn == false){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Log in failed!'), backgroundColor: Colors.red,)
                      );
                    }
                  }
                },
                child: const Text('Login'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

