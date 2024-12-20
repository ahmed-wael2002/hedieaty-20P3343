import 'package:flutter/material.dart';
import 'package:lecture_code/features/gifts/domain/entity/gift.dart';
import 'package:lecture_code/features/notification/data/firebase_messaging_api/push_notification_service.dart';
import 'package:lecture_code/features/users/domain/entity/user.dart';
import 'package:lecture_code/features/users/presentation/state_management/user_provider.dart';
import 'package:provider/provider.dart';

import '../state_management/gift_provider.dart';
import 'gift_edit_sheet.dart';

class GiftListTile extends StatelessWidget {
  final bool isRemote;
  final bool isEditable;
  final GiftEntity gift;
  final ValueChanged<GiftEntity> onDismissedCallback;

  const GiftListTile({
    super.key,
    required this.gift,
    required this.isEditable,
    required this.isRemote,
    required this.onDismissedCallback, // Callback to notify the parent widget
  });

  @override
  Widget build(BuildContext context) {
    final giftProvider = Provider.of<GiftProvider>(context, listen: true);
    final userProvider = Provider.of<UserProvider>(context, listen: true);

    Widget tile = ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.grey[200],
        backgroundImage: gift.imageUrl.isNotEmpty ? NetworkImage(gift.imageUrl) : null,
        child: gift.imageUrl.isEmpty ? const Icon(Icons.image, color: Colors.grey) : null,
      ),
      title: Text(gift.name, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(gift.description),
          Text('${gift.price} EGP'),
        ],
      ),
      trailing: Checkbox(
        value: gift.isPledged,
        activeColor: Theme.of(context).colorScheme.primary,
        checkColor: Colors.white,
        side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
        onChanged: (bool? value) async {
          if (value != null) {
            gift.isPledged = value;
            giftProvider.updateGift(gift: gift, isRemote: isRemote);
            if (!isEditable) {
              UserEntity? owner = await userProvider.getUser(gift.userId);
              if (owner != null) {
                PushNotificationService.sendNotificationToDevice(
                  deviceToken: owner.fcmToken!,
                  title: value ? 'Gift Pledged' : 'Gift Unpledged',
                  body: '${gift.name} has been ${value ? 'pledged' : 'unpledged'}',
                );
              }
            }
          }
        },
      ),
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
    );

    if (!isEditable) return tile;

    return Dismissible(
      key: ValueKey(gift.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
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
        bool? result = await giftProvider.deleteGift(gift: gift, isRemote: isRemote);
        if (result ?? false) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gift deleted successfully'), backgroundColor: Colors.green),
          );
          // Notify the parent widget to remove the gift
          onDismissedCallback(gift);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error deleting gift')),
          );
        }
      },
      child: tile,
    );
  }
}
