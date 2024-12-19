import 'package:flutter/material.dart';
import 'package:lecture_code/common/helpers/validators.dart';
import 'package:lecture_code/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:lecture_code/features/users/domain/entity/user.dart';
import 'package:lecture_code/features/users/presentation/state_management/user_provider.dart';
import 'package:provider/provider.dart';

class UpdateProfilePage extends StatefulWidget {
  final UserEntity user;
  const UpdateProfilePage({super.key, required this.user});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.name ?? '';
    _emailController.text = widget.user.email ?? '';
    _phoneNumberController.text = widget.user.phoneNumber ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Update Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          AssetImage('assets/images/Ahmed Wael.jpg'),
                    ),
                    const SizedBox(height: 20),
                    CustomFormTextField(
                        controller: _nameController,
                        validator: FormFieldValidators.name,
                        labelText: 'Full Name',
                        hintText: 'Enter your full name',
                        inputType: TextInputType.name),
                    const SizedBox(height: 20),
                    CustomFormTextField(
                        controller: _emailController,
                        validator: FormFieldValidators.email,
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        inputType: TextInputType.emailAddress),
                    const SizedBox(height: 20),
                    CustomFormTextField(
                        controller: _phoneNumberController,
                        validator: FormFieldValidators.number,
                        labelText: 'Phone Number',
                        hintText: 'Enter your phone number',
                        inputType: TextInputType.phone),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            bool? success = false;
                            success = await userProvider
                                .updateUser(UserEntity(
                                    widget.user.uid,
                                    _nameController.text,
                                    _emailController.text,
                                    _phoneNumberController.text,
                                    widget.user.friendsList,
                                    widget.user.eventsList,
                                    widget.user.fcmToken
                            ))
                                .then((value) => value);
                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Profile updated successfully')));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Failed to update profile')));
                            }
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Update Profile')),
                  ],
                ),
              )),
        ),
      );
    });
  }
}
