import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(dynamic) validator;
  final String labelText;
  final String hintText;
  final TextInputType inputType;

  // Constructor
  const CustomFormTextField({
    required this.controller,
    required this.validator,
    required this.labelText,
    required this.hintText,
    required this.inputType,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: inputType,
      decoration: _inputDecoration(labelText, hintText),
    );
  }
}

var textFieldBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(12), // Rounded corners
);

Map<String, dynamic> keyboardTypes = {
  'email': TextInputType.emailAddress,
  'username': TextInputType.name,
  'password': TextInputType.visiblePassword,
};

_inputDecoration(
    String labelText,
    String hintText,
    )
{
  return InputDecoration(
    labelText: labelText,
    hintText: hintText,
  );
}

