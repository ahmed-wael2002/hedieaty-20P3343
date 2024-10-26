import 'gift.dart';
import 'package:flutter/material.dart';

var icons = {
  'default':const Icon(Icons.question_mark),
  'birthday':const Icon(Icons.cake),
  'educatuion':const Icon(Icons.school),
  'baby':const Icon(Icons.child_friendly),
};

class Event{
  late String _title;
  late var _type;
  List<Gift>? _giftsList;


  Event(String title, String type){
    _title = title;
    _type = (icons.containsKey(type)) ? icons[type] : icons['default'];
    _giftsList = null;
  }

  // Function to add a new friend to an existing list of friends
  bool addGift(Gift gift) {
    _giftsList?.add(gift);
    return _giftsList != null;
  }

  bool removeGift(Gift gift) {
    return _giftsList?.remove(gift) ?? false;
  }

  get type => _type;

  set type(value) {
    _type = (icons.containsKey(type)) ? icons[type] : icons['default'];
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  // Overriding == operator and hashCode
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Event && runtimeType == other.runtimeType && _title == other._title;

  @override
  int get hashCode => _title.hashCode;
}