import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String email;

  const ProfileWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.email
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      child:Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80, // Size of the circular frame
            height: 80,
            child: ClipOval(
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 30),
          Column(
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                email,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    )
    );
  }
}
