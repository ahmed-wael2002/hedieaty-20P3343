// import 'package:floor/floor.dart';

import '../../domain/entity/event.dart';

class EventModel{
  final String? id;
  final String? title;
  final String? description;
  final String? date;
  final String? location;
  final String? category;
  final String? userId;
  // final List<String>? giftsIds;

  EventModel(
    this.id,
    this.title,
    this.description,
    this.date,
    this.location,
    this.category,
    this.userId,
    // this.giftsIds
  );

  factory EventModel.fromMap(Map<String, dynamic> eventData) {
    return EventModel(
      eventData['id'] as String,
      eventData['title'] as String,
      eventData['description'] as String,
      eventData['date'],
      eventData['location'] as String,
      eventData['category'] as String,
      eventData['userId'] as String,
      // (eventData['gifts'] as List<dynamic>).map((gift) => gift.toString()).toList()
    );
  }

  factory EventModel.fromEntity(EventEntity event) {
    return EventModel(
      event.id,
      event.title,
      event.description,
      event.date.toString(),
      event.location,
      event.category,
      event.userId,
      // []
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toString(),
      'location': location,
      'category': category,
      'userId': userId,
      // 'gifts': giftsIds
    };
  }

}