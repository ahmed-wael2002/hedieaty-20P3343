import 'package:flutter/material.dart';
import 'package:lecture_code/common/helpers/validators.dart';
import 'package:lecture_code/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:lecture_code/features/events/domain/entity/event.dart';
import 'package:uuid/uuid.dart';

class EventModalSheet extends StatefulWidget {
  final Function(EventEntity) onSave;
  final EventEntity event;
  final bool isEditing;

  const EventModalSheet({super.key, required this.event, required this.onSave, required this.isEditing});

  @override
  EventModalSheetState createState() => EventModalSheetState();
}

class EventModalSheetState extends State<EventModalSheet> {
  final _formKey = GlobalKey<FormState>();
  // final String? id;
  // final String? title;
  // final String? description;
  // final DateTime? date;
  // final String? location;
  // final String? category;
  // final String? userId;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _locationController;
  late TextEditingController _categoryController;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    // Todo: Initialize controllers
    _titleController = TextEditingController(text: widget.event.title);
    _descriptionController = TextEditingController(text: widget.event.description);
    _locationController = TextEditingController(text: widget.event.location);
    _categoryController = TextEditingController(text: widget.event.category);
    selectedDate = widget.event.date;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard when tapping outside
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.isEditing ? 'Edit Event' : 'Add Event',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 16),
                // Name
                CustomFormTextField(
                    controller: _titleController,
                    validator: FormFieldValidators.name,
                    labelText: 'Title',
                    hintText: 'Enter an event title',
                    inputType: TextInputType.text,
                ),
                const SizedBox(height: 8),
                // Description
                CustomFormTextField(
                    controller: _descriptionController,
                    validator: FormFieldValidators.name,
                    labelText: 'Description',
                    hintText: 'Enter an event description',
                    inputType: TextInputType.text,
                ),
                const SizedBox(height: 8),
                // Location
                CustomFormTextField(
                    controller: _locationController,
                    validator: FormFieldValidators.name,
                    labelText: 'Location',
                    hintText: 'Enter an event location',
                    inputType: TextInputType.text,
                ),
                const SizedBox(height: 8),
                // Category
                CustomFormTextField(
                    controller: _categoryController,
                    validator: FormFieldValidators.name,
                    labelText: 'Category',
                    hintText: 'Enter an event category',
                    inputType: TextInputType.text,
                ),
                const SizedBox(height: 8),
                // Date
                Row(
                  children: [
                    Text('Date: ${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}'),
                    IconButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: selectedDate ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              selectedDate = value;
                            });
                          }
                        });
                      },
                      icon: const Icon(Icons.calendar_today),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Save button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final event = EventEntity(
                            id: widget.isEditing ? widget.event.id : const Uuid().v4(),
                            title: _titleController.text,
                            description: _descriptionController.text,
                            date: selectedDate,
                            location: _locationController.text,
                            category: _categoryController.text,
                            userId: widget.event.userId,
                          );
                          widget.onSave(event);
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Save'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
