import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

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
    return SpeedDial(
      icon: LineAwesomeIcons.plus,
      activeIcon: LineAwesomeIcons.times,
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      children: [
        _speedDialChild(LineAwesomeIcons.user_friends, 'Add Friend', (){}),
        _speedDialChild(LineAwesomeIcons.calendar, 'Add Event', (){})
      ],
    );
  }
}
