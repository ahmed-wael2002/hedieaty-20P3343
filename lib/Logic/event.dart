import 'gift.dart';
import 'package:flutter/material.dart';

var icons = {
  'default':const Icon(Icons.question_mark),
  'birthday':const Icon(Icons.cake),
  'educatuion':const Icon(Icons.school),
  'baby':const Icon(Icons.child_friendly),
};

class Event{
  late String _name;
  late var _type;
  static int _numberOfGifts = 0;
  List<Gift>? _giftsList;

  Event(String name, String type){
    _name = name;
    _type = (icons.containsKey(type)) ? icons[type] : icons['default'];
    _giftsList = null;
  }

  // Function to add a new friend to an existing list of friends
  bool addGift(Gift gift) {
    _numberOfGifts++;
    _giftsList?.add(gift);
    return _giftsList != null;
  }

  bool removeGift(Gift gift) {
    _numberOfGifts--;
    return _giftsList?.remove(gift) ?? false;
  }

  get type => _type;

  set type(value) {
    _type = (icons.containsKey(type)) ? icons[type] : icons['default'];
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  // Overriding == operator and hashCode
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Event && runtimeType == other.runtimeType && _name == other._name;

  @override
  int get hashCode => _name.hashCode;

  int get numberOfGifts => _numberOfGifts;

  List<Gift>? get giftsList => _giftsList;
}