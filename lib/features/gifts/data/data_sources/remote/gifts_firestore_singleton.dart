import 'package:lecture_code/common/remote/firestore_singleton.dart';

import '../../../domain/entity/gift.dart';

class GiftFirestore{
  static final GiftFirestore _instance = GiftFirestore._internal();
  factory GiftFirestore() => _instance;
  GiftFirestore._internal();

  final FirestoreService _firestore = FirestoreService.instance;
  final _collectionId = 'gifts';

  Future<List<GiftEntity>?> getGifts(String eventId) async {
    final gifts = await _firestore.fetchCollectionByQuery(
        collectionPath: _collectionId,
        field: 'eventId',
        value: eventId,
        operator: QueryOperator.isEqualTo
    );
    return gifts.map((gift) => GiftEntity.fromMap(gift)).toList();
  }

  Future<List<GiftEntity>?> getPledgedGifts(String userId) async {
    final gifts =  await _firestore.fetchCollectionByMultipleQuery(
        collectionPath: _collectionId,
        conditions: [
          QueryCondition(field: 'userId', operator: QueryOperator.isEqualTo, value: userId),
          QueryCondition(field: 'isPledged', operator: QueryOperator.isEqualTo, value: true)
        ]
    );
    return gifts.map((gift) => GiftEntity.fromMap(gift)).toList();
  }

  Future<void> addGift(GiftEntity gift) async {
    await _firestore.addDocument(collectionPath: _collectionId, documentId: gift.id, data: gift.toMap());
  }

  Future<void> updateGift(GiftEntity gift) async {
    await _firestore.updateDocument(collectionPath: _collectionId, documentId: gift.id, data: gift.toMap());
  }

  Future<void> deleteGift(GiftEntity gift) async {
    await _firestore.deleteDocument(collectionPath: _collectionId, documentId: gift.id);
  }

  Future<GiftEntity?> getGiftById(String giftId) async{
    final snapshot = await _firestore.fetchDocument(collectionPath: _collectionId, documentId: giftId);
    return snapshot != null ? GiftEntity.fromMap(snapshot) : null;
  }
}