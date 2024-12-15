import 'package:flutter/material.dart';
import 'package:lecture_code/features/gifts/domain/entity/gift.dart';
import 'package:provider/provider.dart';

import '../state_management/gift_provider.dart';
import 'gift_edit_sheet.dart';

class GiftListTile extends StatelessWidget {
  final GiftEntity gift;

  const GiftListTile({super.key, required this.gift});

  @override
  Widget build(BuildContext context) {
    final giftProvider = Provider.of<GiftProvider>(context, listen: true);

    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: Text(gift.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(gift.description),
          Text('${gift.price} EGP'),
        ],
      ),
      leading: Checkbox(
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
            giftProvider.updateGift(gift);
          }
        },
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () async {
          bool? result = await giftProvider.deleteGift(gift);
          if(result ?? false){
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
      ),

      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => GiftEditSheet(
            gift: gift,
            isEditing: true,
            onSave: (gift) {
              giftProvider.updateGift(gift);
            },
          ),
        );
      },
    );
  }
}
