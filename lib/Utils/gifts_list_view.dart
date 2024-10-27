import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../Logic/gift.dart';

class GiftsList extends StatefulWidget {
  final List<Gift> gifts;
  const GiftsList({super.key, required this.gifts});

  @override
  State<GiftsList> createState() => _GiftsListState();
}

class _GiftsListState extends State<GiftsList> {
  late List<Gift> _gifts;

  @override
  void initState() {
    super.initState();
    _gifts = widget.gifts;
  }

  @override
  Widget build(BuildContext context) {
    return _gifts.isEmpty
        ? Center(
      child: Image.asset(
        'assets/images/empty.png',
        width: 200,
        height: 200,
      ),
    )
        : ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: _gifts.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            _gifts[index].name,
            style: TextStyle(
              decoration: _gifts[index].isPledged ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
          leading: CircleAvatar(
            backgroundImage: AssetImage(_gifts[index].imageUrl),
            radius: 30,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: _gifts[index].isPledged,
                onChanged: (bool? value) {
                  setState(() {
                    _gifts[index].isPledged = value ?? false;
                  });
                },
              ),
              IconButton(
                onPressed: () => setState(() {
                  widget.gifts!.removeAt(index);
                }),
                icon: const Icon(LineAwesomeIcons.trash, color: Colors.red),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
    );
  }
}
