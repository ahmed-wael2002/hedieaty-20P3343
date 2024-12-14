import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entity/gift.dart';

class GiftFirestore{
  static final GiftFirestore _instance = GiftFirestore._internal();
  factory GiftFirestore() => _instance;
  GiftFirestore._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _collectionId = 'gifts';

  Future<List<GiftEntity>> getGifts() async {
    final snapshot = await _firestore.collection(_collectionId).get();
    return snapshot.docs.map((doc) => GiftEntity.fromMap(doc.data())).toList();
  }

  Future<void> addGift(GiftEntity gift) async {
    await _firestore.collection(_collectionId).add(gift.toMap());
  }

  Future<void> updateGift(GiftEntity gift) async {
    await _firestore.collection(_collectionId).doc(gift.id).update(gift.toMap());
  }

  Future<void> deleteGift(GiftEntity gift) async {
    await _firestore.collection(_collectionId).doc(gift.id).delete();
  }

  Stream<List<String>> getGiftsStream(String eventId) {
    return _firestore.collection(_collectionId).where('eventId', isEqualTo: eventId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.id).toList();
    });
  }
}