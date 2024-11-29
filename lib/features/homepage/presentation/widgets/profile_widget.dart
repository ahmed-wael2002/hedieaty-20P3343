import 'package:flutter/material.dart';
import 'package:lecture_code/features/homepage/presentation/state_management/homepage_provider.dart';
import 'package:provider/provider.dart';

import '../../domain/entity/user.dart';

class ProfileWidget extends StatelessWidget {

  final UserEntity user;

  const ProfileWidget({
    super.key, required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final homepageProvider = Provider.of<HomepageProvider>(context);
    return Container(
      margin: const EdgeInsets.all(16.0),
      child:Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 80, // Size of the circular frame
            height: 80,
            child: ClipOval(
              child: Image.asset(
                'assets/images/Ahmed Wael.jpg',
                // homepageProvider.user.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name ?? 'unknown',
                style: Theme.of(context).textTheme.headlineMedium
              ),
              Text(
                user.email ?? 'unknown',
                style: Theme.of(context).textTheme.titleMedium
              ),
            ],
          ),
        ],
      ),
    )
    );
  }
}
