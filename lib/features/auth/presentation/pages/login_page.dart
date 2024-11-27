import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_password_field.dart';
import '../widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> updateLoginCache() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
  }

  Future<void> logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
  }


  String? _emailValidator(email) {
    if (email == null || email.isEmpty) {
      return "Please enter an email address";
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
        .hasMatch(email)) {
      return "Please enter a valid email address";
    }
    return null;
  }

  String? _passwordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    // Email text field
                    CustomFormTextField(
                      controller: _emailController,
                      validator: _emailValidator,
                      labelText: 'Email',
                      hintText: 'Enter your email address',
                      inputType: keyboardTypes['email'],
                    ),

                    // Spacing
                    const SizedBox(
                      height: 20,
                    ),

                    // Password field
                    CustomPasswordField(
                        controller: _passwordController,
                        validator: _passwordValidator,
                        labelText: 'Email',
                        hintText: 'Enter your password',
                    ),

                    // Vertical spacing
                    const SizedBox(
                      height: 20,
                    ),

                    // Login Button
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: (){}, child: const Text('Login'))),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(children: [
                      Expanded(
                          child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      )),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'or Login with',
                        style: TextStyle(color: Colors.purple),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      )),
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                        child: ElevatedButton.icon(
                            onPressed: (){},
                            icon: Image.asset('assets/images/google.png',
                                scale: 20),
                            label: const Text('Login with Google')
                        )
                    ),
                    const SizedBox(height: 20,),
                    GestureDetector(
                      child: Expanded(child:Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () {
                              // Todo: Create a SignUp page
                            },
                            child: const Text(
                              'Create a new account',
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      )
                    )
                    )
                  ],
                )
            )
        )
    );
  }
}
