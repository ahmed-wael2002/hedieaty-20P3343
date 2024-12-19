import 'package:flutter/material.dart';
import 'package:lecture_code/features/auth/presentation/state_mgmt/auth_provider.dart';
import 'package:lecture_code/features/users/presentation/pages/update_profile_page.dart';
import 'package:lecture_code/features/users/presentation/state_management/user_provider.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../domain/entity/user.dart';

class ProfilePage extends StatelessWidget {
  final UserEntity user;
  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Center(
              child: Text("Profile",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            leading: IconButton(
              icon: const Icon(LineAwesomeIcons.angle_left),
              onPressed: () => Navigator.pop(context),
            )),
        body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /* Profile Picture view */
                Stack(
                  children: [
                    // Profile picture and edit button
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(image: AssetImage('assets/images/default.jpg')),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.pink),
                        child: const Icon(
                          LineAwesomeIcons.alternate_pencil,
                          size: 20,
                          color: Colors.white,
                        ),
                      )
                    ),
                  ],
                ),
                Text(
                  user.name!,
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),
                ),
                Text(
                  user.email!,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MultiProvider(
                            providers: [
                              ChangeNotifierProvider(create: (_) => UserProvider()),
                              ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
                            ],
                            child: UpdateProfilePage(user: user),
                          )
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      side: BorderSide.none,
                      shape: const StadiumBorder(),
                    ),
                    child: const Text('Edit Profile',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                ProfileMenuWidget(
                    title: 'Settings',
                    icon: LineAwesomeIcons.cog,
                    onPress: () {}),
                ProfileMenuWidget(
                    title: 'Events',
                    icon: LineAwesomeIcons.calendar,
                    onPress: () {}),
                ProfileMenuWidget(
                    title: 'Information',
                    icon: LineAwesomeIcons.info,
                    onPress: () {}),
              ],
        ))));
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPress});

  // Attributes
  final String title;
  final IconData icon;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onPress,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.pink[100],
          ),
          child: Icon(icon, color: Colors.black),
        ),
        title: Text(title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            )),
        trailing: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey[100]),
          child: const Icon(LineAwesomeIcons.angle_right,
              size: 18.0, color: Colors.grey),
        ));
  }
}
