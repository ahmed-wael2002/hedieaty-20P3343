import 'package:flutter/material.dart';
import '../Logic/event.dart';

class CreateEventForm extends StatefulWidget {
  const CreateEventForm({super.key});

  @override
  _CreateEventFormState createState() => _CreateEventFormState();
}

class _CreateEventFormState extends State<CreateEventForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _selectedType = 'default';
  final List<String> _eventTypes = ['default', 'birthday', 'education', 'baby'];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name for the event';
              }
              return null;
            },
          ),
          DropdownButtonFormField<String>(
            value: _selectedType,
            decoration: const InputDecoration(labelText: 'Event Type'),
            items: _eventTypes.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedType = newValue!;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String name = _nameController.text;
                    Navigator.of(context).pop(Event(name, _selectedType));
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
