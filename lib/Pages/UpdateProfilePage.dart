import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../Logic/user.dart';

class UpdateProfilePage extends StatelessWidget {
  const UpdateProfilePage({super.key, required this.user});
  final User user;

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
        )
      ),
      body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
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
                          child: Image(image: AssetImage(user.imageUrl)),
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
                              LineAwesomeIcons.camera,
                              size: 20,
                              color: Colors.white,
                            ),
                          )
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Form(child: Column(
                    children: [
                    TextFormField(
                      decoration: InputDecoration(
                        label: const Text('Full Name'),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),),
                        prefixIcon: const Icon(LineAwesomeIcons.user),
                        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.black)),
                      )
                    ),

                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: InputDecoration(
                        label: const Text('E-mail'),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),),
                        prefixIcon: const Icon(LineAwesomeIcons.envelope),
                        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.black)),
                      )
                    ),

                    const SizedBox(height: 15),
                    TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      label: const Text('Password'),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),),
                      prefixIcon: const Icon(LineAwesomeIcons.lock),
                      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.black)),
                    )
                  ),

                    const SizedBox(height: 15),
                    SizedBox(
                      width: 1000,
                      height: 50,
                      child:ElevatedButton(
                        onPressed:(){
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                        child: const Text('Submit Changes', style: TextStyle(color: Colors.white, fontSize: 15),),
                      ),
                    ),

                  ],
                  )
                  )
                ],
              )
          )
      )
    );
  }
}
