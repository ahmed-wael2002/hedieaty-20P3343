import 'package:flutter/material.dart';
import 'package:lecture_code/features/gifts/domain/entity/gift.dart';
import 'package:provider/provider.dart';

import '../state_management/gift_provider.dart';
import 'gift_edit_sheet.dart';

class GiftListTile extends StatelessWidget {
  final bool isRemote;
  final bool isEditable;
  final GiftEntity gift;

  const GiftListTile({
    super.key,
    required this.gift,
    required this.isEditable,
    required this.isRemote,
  });

  @override
  Widget build(BuildContext context) {
    final giftProvider = Provider.of<GiftProvider>(context, listen: true);

    return Dismissible(
      key: ValueKey(gift.id), // Use a unique key for each item
      direction: DismissDirection.endToStart, // Swipe left to delete
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        // Confirm the deletion
        return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm Deletion'),
            content: const Text('Are you sure you want to delete this gift?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) async {
        // Perform deletion
        bool? result = await giftProvider.deleteGift(gift: gift, isRemote: isRemote);
        if (result ?? false) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Gift deleted successfully'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error deleting gift'),
            ),
          );
        }
      },
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        // Leading: Circular avatar with network image
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey[200],
          backgroundImage: gift.imageUrl.isNotEmpty
              ? NetworkImage(gift.imageUrl)
              : null,
          child: gift.imageUrl.isEmpty
              ? const Icon(Icons.image, color: Colors.grey)
              : null,
        ),

        // Title and Subtitle
        title: Text(gift.name, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(gift.description),
            Text('${gift.price} EGP'),
          ],
        ),

        // Trailing: Checkbox only
        trailing: Checkbox(
          value: gift.isPledged,
          activeColor: Theme.of(context).colorScheme.primary,
          checkColor: Colors.white,
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
          onChanged: (bool? value) {
            if (value != null) {
              // Update isPledged value
              gift.isPledged = value;
              // Call the eventProvider to update the gift
              giftProvider.updateGift(gift: gift, isRemote: isRemote);
            }
          },
        ),

        // On Tap: Open edit sheet (only if editable)
        onTap: isEditable
            ? () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => GiftEditSheet(
              gift: gift,
              isEditing: true,
              uploadImage: () {
                return giftProvider.uploadImage();
              },
              onSave: (gift) {
                giftProvider.updateGift(gift: gift, isRemote: isRemote);
              },
            ),
          );
        }
            : null,
      ),
    );
  }
}
