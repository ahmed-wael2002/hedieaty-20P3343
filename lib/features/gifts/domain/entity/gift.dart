import '../../data/models/gift.dart';

class GiftEntity{
  final String id;
  final String name;
  final String description;
  final String category;
  final String price;
  bool isPledged;
  final String eventId;
  final String userId;
  final String imageUrl;

  GiftEntity({
    required this.imageUrl,
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.isPledged,
    required this.eventId,
    required this.userId,
  });

  GiftEntity copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    String? price,
    bool? isPledged,
    String? eventId,
    String? userId,
  }) {
    return GiftEntity(
      imageUrl: imageUrl,
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
      isPledged: isPledged ?? this.isPledged,
      eventId: eventId ?? this.eventId,
      userId: userId ?? this.userId,
    );
  }

  @override
  bool operator ==(Object other) {
    if(identical(this, other)) return true;

    return other is GiftEntity &&
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.category == category &&
      other.price == price &&
      other.isPledged == isPledged &&
      other.eventId == eventId &&
      other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      category.hashCode ^
      price.hashCode ^
      isPledged.hashCode ^
      eventId.hashCode ^
      userId.hashCode;
  }

  static GiftEntity fromMap(Map<String, dynamic> giftMap) {
    return GiftEntity(
      imageUrl: giftMap['imageUrl'] as String,
      id: giftMap['id'] as String,
      name: giftMap['name'] as String,
      description: giftMap['description'] as String,
      category: giftMap['category'] as String,
      price: giftMap['price'] as String,
      isPledged: giftMap['isPledged'] as bool,
      eventId: giftMap['eventId'] as String,
      userId: giftMap['userId'] as String,
    );
  }

  factory GiftEntity.fromModel(GiftModel gift){
    return GiftEntity(
      imageUrl: gift.imageUrl,
      id: gift.id,
      name: gift.name,
      description: gift.description,
      category: gift.category,
      price: gift.price,
      isPledged: bool.parse(gift.isPledged),
      eventId: gift.eventId,
      userId: gift.userId,
    );

  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'price': price,
      'isPledged': isPledged,
      'eventId': eventId,
      'userId': userId,
    };
  }
}