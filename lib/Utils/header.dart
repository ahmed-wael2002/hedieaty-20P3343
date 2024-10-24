import 'package:flutter/material.dart';

// Custom reusable AppBar widget
class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      // Title is formatted to be bold
      title: const Center(child: Text("Hedieaty", style: TextStyle(fontWeight: FontWeight.bold)),),
      elevation: 0,
      // Leading for placing icons to the left side
      leading: IconButton(
        icon: const Icon(Icons.notifications),
        onPressed: () => { print("Menu is pressed!") },
      ),
      // Actions for placing icons to the right side
      actions: [
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => { print("User is logging out!") },
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}