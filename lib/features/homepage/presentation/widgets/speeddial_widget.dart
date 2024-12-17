import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:lecture_code/features/events/presentation/widgets/event_modal_sheet.dart';
import 'package:lecture_code/features/users/presentation/state_management/user_provider.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';


import '../../../events/domain/entity/event.dart';
import '../../../events/presentation/state_management/event_provider.dart';


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
        _speedDialChild(LineAwesomeIcons.user_plus, 'Add Friend', () { showPhoneNumberPopup(context, addFriendFn); }),
        _speedDialChild(LineAwesomeIcons.calendar_plus, 'Add Public Event', (){ showEventModalSheet(context, true);}),
        _speedDialChild(LineAwesomeIcons.calendar_times_1, 'Add Private Event', (){ showEventModalSheet(context, false);}),
      ],
    );
  }

  void showEventModalSheet(BuildContext context, bool isRemote){
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var eventProvider = Provider.of<EventProvider>(context, listen: false);

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context)=>EventModalSheet(
          event: EventEntity(
              id: const Uuid().v4(),
              title: '',
              description: '',
              date: DateTime.now(),
              location: '',
              category: '',
              userId: userProvider.user!.uid
          ),
          onSave: (event){
              eventProvider.createEvent(event: event, context: context, isRemote: isRemote);
              userProvider.addEvent(event);
          },
          isEditing: false
      )
    );
  }


  void showPhoneNumberPopup(BuildContext context, Function(String) onOkPressed) {
    // Controller to manage the text field input
    final TextEditingController phoneNumberController = TextEditingController();
    String phoneNumber;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Phone Number'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  hintText: 'Phone Number',
                ),
                keyboardType: TextInputType.phone,  // Show numeric keyboard for phone input
              ),
              TextButton(
                  onPressed: () async{
                    // Add phone number from contacts
                    final permission = FlutterContactPicker.requestPermission();
                    if(await permission){
                      FlutterContactPicker.pickPhoneContact().then((contact) {
                        phoneNumberController.text = contact.phoneNumber!.number.toString().replaceAll(' ', '');
                      });
                    }
                  },
                  child: const Text('Add from contacts'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Get the value from the text field
                phoneNumber = phoneNumberController.text;
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
