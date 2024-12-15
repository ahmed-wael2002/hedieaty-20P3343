import 'package:flutter/material.dart';
import 'package:lecture_code/common/helpers/validators.dart';
import 'package:lecture_code/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entity/gift.dart';

class GiftEditSheet extends StatefulWidget {
  final Function(GiftEntity) onSave;
  final GiftEntity gift;
  final bool isEditing;

  const GiftEditSheet({super.key, required this.gift, required this.onSave, required this.isEditing});

  @override
  GiftEditSheetState createState() => GiftEditSheetState();
}

class GiftEditSheetState extends State<GiftEditSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.gift.name);
    _descriptionController =
        TextEditingController(text: widget.gift.description);
    _priceController = TextEditingController(text: widget.gift.price);
    _categoryController = TextEditingController(text: widget.gift.category);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Gift',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 16),
              // Name
              CustomFormTextField(
                controller: _nameController,
                validator: FormFieldValidators.name,
                labelText: 'Name',
                hintText: 'Enter gift name',
                inputType: TextInputType.text,
              ),
              const SizedBox(height: 8),
              // Description
              CustomFormTextField(
                controller: _descriptionController,
                validator: FormFieldValidators.name,
                labelText: 'Description',
                hintText: 'Enter gift description',
                inputType: TextInputType.text,
              ),
              const SizedBox(height: 8),
              // Category
              CustomFormTextField(
                controller: _categoryController,
                validator: FormFieldValidators.name,
                labelText: 'Category',
                hintText: 'Enter gift category',
                inputType: TextInputType.text,
              ),
              const SizedBox(height: 8),
              // Price
              CustomFormTextField(
                controller: _priceController,
                validator: FormFieldValidators.number,
                labelText: 'Price',
                hintText: 'Enter gift price',
                inputType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              // Save button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final newGift = GiftEntity(
                          id: widget.isEditing ? widget.gift.id : const Uuid().v4() ,
                          name: _nameController.text.trim(),
                          description: _descriptionController.text.trim(),
                          category: _categoryController.text.trim(),
                          price: _priceController.text.trim(),
                          isPledged: false,
                          eventId: widget.gift.eventId,
                          userId: widget.gift.userId,
                        );
                        widget.onSave(newGift);
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
    );
  }
}
