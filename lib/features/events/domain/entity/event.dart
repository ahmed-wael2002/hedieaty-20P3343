import '../../data/model/event.dart';

class EventEntity{
  final String? id;
  final String? title;
  final String? description;
  final DateTime? date;
  final String? location;
  final String? category;
  final String? userId;

  EventEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.category,
    required this.userId,
  });

  factory EventEntity.fromModel(EventModel model){
    return EventEntity(
      id: model.id,
      title: model.title,
      description: model.description,
      date: model.date,
      location: model.location,
      category: model.category,
      userId: model.userId,
    );
  }

  @override
  bool operator ==(Object other) {
    if(identical(this, other)) return true;

    return other is EventEntity &&
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.date == date &&
      other.location == location &&
      other.category == category &&
      other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      date.hashCode ^
      location.hashCode ^
      category.hashCode ^
      userId.hashCode;
  }

  static EventEntity fromMap(Map<String, dynamic> eventMap) {
    return EventEntity(
      id: eventMap['id'] as String,
      title: eventMap['title'] as String,
      description: eventMap['description'] as String,
      date: eventMap['date'].toDate() as DateTime,
      location: eventMap['location'] as String,
      category: eventMap['category'] as String,
      userId: eventMap['userId'] as String,
    );
  }
}