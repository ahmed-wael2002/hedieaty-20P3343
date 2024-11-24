import 'package:flutter/material.dart';
import 'package:lecture_code/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isPasswordVisible = false;

  Future<void> updateLoginCache() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
  }

  Future<void> logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
  }


  void _login() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text;

      if ((email == "admin@admin.com") && (password == '123456')) {
        updateLoginCache();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MyHomePage(title: 'Homepage', logoutCallback: logout,),));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logging in...')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cannot find user!')),
        );
      }
    }
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
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return "Please enter an email address";
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(email)) {
                          return "Please enter a valid email address";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      obscureText: !_isPasswordVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: _login, child: const Text('Login'))),
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
                            onPressed: _login,
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
                            onTap: ()=>print('Create a new account'),
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
