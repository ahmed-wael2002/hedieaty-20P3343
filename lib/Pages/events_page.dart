import 'package:flutter/material.dart';
import 'package:lecture_code/Logic/gift.dart';
import '../Utils/header.dart';
import '../Utils/gifts_list_view.dart';
import '../Logic/event.dart';

class Eventspage extends StatefulWidget {
  final Event event;
  const Eventspage({super.key, required this.event});

  @override
  State<Eventspage> createState() => _EventspageState();
}

class _EventspageState extends State<Eventspage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.event.type,
              const SizedBox(width: 10),
              Text(
                widget.event.name,
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 300,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.event.addGift(Gift('test_gift', 'assets/images/heart.png'));
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                side: BorderSide.none,
                shape: const StadiumBorder(),
              ),
              child: const Text(
                '+ Add Gift',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GiftsList(gifts: widget.event.giftsList),
          ),
        ],
      ),
    );
  }
}
