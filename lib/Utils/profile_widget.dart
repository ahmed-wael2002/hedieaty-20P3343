import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imageUrl;
  final String name;

  const ProfileWidget({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 130, // Size of the circular frame
            height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.purple, // Color of the circular border
                width: 5.0, // Thickness of the circular border
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                width: 80, // Size of the image inside the frame
                height: 80,
              ),
            ),
          ),
          const SizedBox(height: 10), // Space between the picture and the name
          Text(
            name,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
