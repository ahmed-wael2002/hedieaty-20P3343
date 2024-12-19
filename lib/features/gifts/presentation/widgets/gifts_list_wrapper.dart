import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lecture_code/features/gifts/presentation/state_management/gift_provider.dart';
import 'package:lecture_code/features/users/presentation/state_management/user_provider.dart';
import '../../../events/domain/entity/event.dart';
import '../../domain/entity/gift.dart';
import 'gift_list_tile.dart';
import 'gift_list_view.dart'; // or wherever your GiftListTile is used

class GiftsListWrapper extends StatelessWidget {
  final bool isRemote;
  final bool isEditable;
  final EventEntity? event;
  final String? userId;

  const GiftsListWrapper({
    required this.isEditable,
    this.event,
    this.userId,
    super.key,
    required this.isRemote,
  });

  @override
  Widget build(BuildContext context) {
    // Wrapping providers in the build method
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GiftProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: FutureBuilder(
        future: (event == null)
            ? Provider.of<GiftProvider>(context, listen: false).getPledgedGifts(
            userId: Provider.of<UserProvider>(context, listen: false).user?.uid ?? '',
            isRemote: isRemote)
            : Provider.of<GiftProvider>(context, listen: false).getGifts(
            eventId: event!.id!,
            isRemote: isRemote),
        builder: (context, snapshot) {
          print('From gift list wrapper: ${Provider.of<UserProvider>(context, listen: true).user?.name}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('An error occurred'));
          }
          if (snapshot.hasData) {
            final gifts = snapshot.data as List<GiftEntity>;
            return GiftsListView(
              isRemote: isRemote,
              gifts: gifts,
              isEditable: isEditable,
            );
          }
          return const Center(child: Text('No gifts found'));
        },
      ),
    );
  }
}
