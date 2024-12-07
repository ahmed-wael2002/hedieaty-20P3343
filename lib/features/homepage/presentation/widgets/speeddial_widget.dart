import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:lecture_code/features/homepage/presentation/state_management/user_provider.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';


class SpeeddialButton extends StatelessWidget {
  const SpeeddialButton({super.key});

  _speedDialChild(IconData icon, label, fn){
    return SpeedDialChild(
      child: Icon(icon),
      label: label,
      onTap: fn,
    );
  }


  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    final addFriendFn = userProvider.addFriend;

    return SpeedDial(
      elevation: 5,
      icon: LineAwesomeIcons.plus,
      activeIcon: LineAwesomeIcons.times,
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      children: [
        _speedDialChild(LineAwesomeIcons.user_friends, 'Add Friend', () { showPhoneNumberPopup(context, addFriendFn); }),
        _speedDialChild(LineAwesomeIcons.calendar, 'Add Event', (){})
      ],
    );
  }

  void showPhoneNumberPopup(BuildContext context, Function(String) onOkPressed) {
    // Controller to manage the text field input
    final TextEditingController phoneNumberController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Phone Number'),
          content: TextField(
            controller: phoneNumberController,
            decoration: const InputDecoration(
              hintText: 'Phone Number',
            ),
            keyboardType: TextInputType.phone,  // Show numeric keyboard for phone input
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Get the value from the text field
                String phoneNumber = phoneNumberController.text;

                // Call the passed function with the phone number input
                if (phoneNumber.isNotEmpty) {
                  onOkPressed(phoneNumber);
                  Navigator.of(context).pop();  // Close the dialog
                } else {
                  // Optionally, you can show a validation message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a phone number')),
                  );
                }
              },
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();  // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

}
