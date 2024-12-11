import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:lecture_code/features/homepage/presentation/state_management/user_provider.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
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
        _speedDialChild(LineAwesomeIcons.user_friends, 'Add Friend', () { showPhoneNumberPopup(context, addFriendFn); }),
        _speedDialChild(LineAwesomeIcons.calendar, 'Add Event', (){ showEventPopup(context); }),
      ],
    );
  }

  void showEventPopup(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController locationController = TextEditingController();
    final TextEditingController categoryController = TextEditingController();
    DateTime? selectedDate;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final eventProvider = Provider.of<EventProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Create Event"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: "Title"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: "Description"),
                ),
                const SizedBox(height: 10),

                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: "Location"),
                ),
                const SizedBox(height: 10),

                TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(labelText: "Category"),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(selectedDate != null
                        ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                        : "Select Date"),
                    const Spacer(),
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: WidgetStateProperty.all(const Size(0, 0)),
                      ),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          selectedDate = pickedDate;
                        }
                      },
                      child: const Text("Pick Date"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty &&
                    selectedDate != null &&
                    locationController.text.isNotEmpty &&
                    categoryController.text.isNotEmpty) {

                  var newEvent = EventEntity(
                    id: const Uuid().v4(),
                    title: titleController.text,
                    description: descriptionController.text,
                    date: selectedDate!,
                    location: locationController.text,
                    category: categoryController.text,
                    userId: userProvider.user!.uid,
                  );

                  eventProvider.createEvent(event: newEvent, context: context);
                  userProvider.addEvent(newEvent);

                  Navigator.of(context).pop();
                }
              },
              child: const Text("Create"),
            ),
          ],
        );
      },
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
