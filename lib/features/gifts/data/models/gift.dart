import '../../domain/entity/gift.dart';

class GiftModel{
  final String id;
  final String name;
  final String description;
  final String category;
  final String price;
  final String isPledged;
  final String eventId;
  final String userId;
  final String imageUrl;

  GiftModel({
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

  factory GiftModel.fromEntity(GiftEntity entity){
    return GiftModel(
      imageUrl: entity.imageUrl,
      id: entity.id,
      name: entity.name,
      description: entity.description,
      category: entity.category,
      price: entity.price,
      isPledged: entity.isPledged.toString(),
      eventId: entity.eventId,
      userId: entity.userId,
    );
  }

  factory GiftModel.fromMap(Map<String, dynamic> giftMap) {
    return GiftModel(
      imageUrl: giftMap['imageUrl'],
      id: giftMap['id'],
      name: giftMap['name'],
      description: giftMap['description'],
      category: giftMap['category'],
      price: giftMap['price'],
      isPledged: giftMap['isPledged'],
      eventId: giftMap['eventId'],
      userId: giftMap['userId'],
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