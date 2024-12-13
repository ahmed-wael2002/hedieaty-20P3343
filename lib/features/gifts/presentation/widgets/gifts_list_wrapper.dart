import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../events/domain/entity/event.dart';
import '../../../users/presentation/state_management/user_provider.dart';
import '../../domain/entity/gift.dart';
import '../state_management/gift_provider.dart';
import 'gift_list_view.dart';

class GiftsListWrapper extends StatelessWidget {
  final bool isRemote;
  final bool isEditable;
  final EventEntity? event;
  final String? userId;
  const GiftsListWrapper({required this.isEditable, this.event, this.userId, super.key, required this.isRemote});

  @override
  Widget build(BuildContext context) {
    final giftsProvider = Provider.of<GiftProvider>(context, listen: true);
    final userProvider = Provider.of<UserProvider>(context, listen: true);

    return FutureBuilder(
        future: (event == null)
            ? giftsProvider.getPledgedGifts(userId: userProvider.user!.uid!, isRemote: isRemote)
            : giftsProvider.getGifts(eventId: event!.id!, isRemote: isRemote),
        builder: (context, snapshot) {
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
        });
  }
}
