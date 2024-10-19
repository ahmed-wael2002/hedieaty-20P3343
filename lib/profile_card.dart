import 'package:flutter/material.dart';

class ProfileInfoWidget extends StatelessWidget {
  final String assetImagePath;
  final String name;
  final int upcomingEvents;

  const ProfileInfoWidget({
    super.key,
    required this.assetImagePath,
    required this.name,
    required this.upcomingEvents,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0), // Padding around the widget
      margin: const EdgeInsets.all(10.0), // Margin outside the widget
      decoration: BoxDecoration(
        color: Colors.grey[200], // Background color for the widget
        borderRadius: BorderRadius.circular(10.0), // Rounded corners for the rectangular widget
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40, // Size of the circular image
            backgroundImage: AssetImage(assetImagePath), // The image from assets
          ),
          const SizedBox(width: 20), // Space between the image and text fields
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5), // Space between the name and the upcoming events
              Text(
                'Upcoming events: $upcomingEvents',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700], // Text color for upcoming events
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


