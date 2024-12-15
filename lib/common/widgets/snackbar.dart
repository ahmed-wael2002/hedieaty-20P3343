import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  final String message;
  final bool success;
  const CustomSnackBar({super.key, required this.message, required this.success});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
    );
  }
}
