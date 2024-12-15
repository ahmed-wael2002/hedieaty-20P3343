import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../common/constants/images_paths.dart';
import '../../../gifts/domain/entity/gift.dart';
import '../../../gifts/presentation/state_management/gift_provider.dart';
import '../../../gifts/presentation/widgets/gift_edit_sheet.dart';
import '../../../gifts/presentation/widgets/gift_list_view.dart';
import '../../domain/entity/event.dart';
// import '../state_management/event_provider.dart';

class EventPage extends StatelessWidget {
  final EventEntity event;
  const EventPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final giftsProvider = Provider.of<GiftProvider>(context, listen: true);
    // final eventProvider = Provider.of<EventProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title ?? 'Unknown'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Hero(
            tag: event.id!,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(defaultEventImagePath),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            event.description ?? 'No description',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            event.date.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: FutureBuilder(
                future: giftsProvider.getGifts(event.id!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('An error occurred'));
                  }
                  if (snapshot.hasData) {
                    final gifts = snapshot.data as List<GiftEntity>;
                    return GiftsListView(gifts);
                  }
                  return const Center(child: Text('No gifts found'));
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        splashColor: Theme.of(context).colorScheme.onPrimaryContainer,
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
              context: context,
              builder: (context) => GiftEditSheet(
                isEditing: false,
                gift: GiftEntity(
                  id: const Uuid().v4(),
                  name: '',
                  description: '',
                  category: '',
                  price: '',
                  isPledged: false,
                  eventId: event.id!,
                  userId: event.userId!,
                ),
                onSave: (gift) {
                  giftsProvider.createGift(gift);
                },
              ),
          );
          // showCreateGiftDialog(context, event.id!, event.userId!, (gift) {
          //   giftsProvider.createGift(gift);
          //   // eventProvider.addGift(event: event, gift: gift, context: context);
          // });
        },
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.surface),
      ),
    );
  }

  // void showCreateGiftDialog(BuildContext context, String eventId, String userId, Function(GiftEntity) onGiftCreated) {
  //   final nameController = TextEditingController();
  //   final descriptionController = TextEditingController();
  //   final categoryController = TextEditingController();
  //   final priceController = TextEditingController();
  //
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Create New Gift'),
  //         content: SingleChildScrollView(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               TextFormField(
  //                 controller: nameController,
  //                 decoration: const InputDecoration(labelText: 'Name'),
  //               ),
  //               const SizedBox(height: 8),
  //               TextFormField(
  //                 controller: descriptionController,
  //                 decoration: const InputDecoration(labelText: 'Description'),
  //               ),
  //               const SizedBox(height: 8),
  //               TextFormField(
  //                 controller: categoryController,
  //                 decoration: const InputDecoration(labelText: 'Category'),
  //               ),
  //               const SizedBox(height: 8),
  //               TextFormField(
  //                 controller: priceController,
  //                 decoration: const InputDecoration(labelText: 'Price'),
  //                 keyboardType: TextInputType.number,
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               final newGift = GiftEntity(
  //                 id: const Uuid().v4(),
  //                 name: nameController.text.trim(),
  //                 description: descriptionController.text.trim(),
  //                 category: categoryController.text.trim(),
  //                 price: priceController.text.trim(),
  //                 isPledged: false,
  //                 eventId: eventId,
  //                 userId: userId,
  //               );
  //               onGiftCreated(newGift);
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Create'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}