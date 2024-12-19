import 'package:flutter/material.dart';
import 'package:lecture_code/common/constants/images_paths.dart';
import 'package:lecture_code/features/gifts/domain/entity/gift.dart';
import 'package:lecture_code/features/gifts/presentation/widgets/gift_list_tile.dart';
import 'package:lecture_code/features/users/presentation/state_management/user_provider.dart';
import 'package:provider/provider.dart';

class GiftsListView extends StatefulWidget {
  final bool isRemote;
  final bool isEditable;
  final List<GiftEntity>? gifts;
  const GiftsListView({required this.gifts, super.key, required this.isEditable, required this.isRemote});

  @override
  State<GiftsListView> createState() => _GiftsListViewState();
}

class _GiftsListViewState extends State<GiftsListView> {
  late List<GiftEntity> _gifts;
  late List<GiftEntity> _filteredGifts;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _gifts = widget.gifts ?? [];
    _filteredGifts = _gifts;
    _searchController  = TextEditingController();
    _searchController.addListener(() {
      filterEvents();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void filterEvents() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredGifts = _gifts.where((gift) {
        return gift.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: true);
    print('From gift list view: ${userProvider.user?.name}');
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Search for a gift...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
          ),
        ),
        Expanded(
          child: _filteredGifts.isEmpty
              ? Center(
            child: Image.asset(
              emptyImagePath,
              width: 200,
              height: 200,
            ),
          )
              : ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: _filteredGifts.length,
            itemBuilder: (BuildContext context, int index) {
              return ChangeNotifierProvider(
                  create: (_) => UserProvider(),
                child: GiftListTile(
                  isRemote: widget.isRemote,
                  isEditable: widget.isEditable,
                  gift: _filteredGifts[index],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
          ),
        ),
      ],
    );
  }
}
