import 'package:lecture_code/features/gifts/data/data_sources/remote/gifts_firestore_singleton.dart';
import 'package:lecture_code/features/gifts/domain/entity/gift.dart';

import '../../../domain/repository/gift_repository.dart';

class GiftRepositoryFirestoreImpl implements GiftRepository {
  final GiftFirestore _giftFirestore = GiftFirestore();

  @override
  Future<void> createGift(GiftEntity gift) {
    return _giftFirestore.addGift(gift);
  }

  @override
  Future<void> deleteGift(GiftEntity gift) {
    return _giftFirestore.deleteGift(gift);
  }

  @override
  Future<GiftEntity?> fetchGift(String giftId) async{
    return await _giftFirestore.getGiftById(giftId);
  }

  @override
  Future<void> updateGift(GiftEntity gift) {
    return _giftFirestore.updateGift(gift);
  }

  @override
  Future<List<GiftEntity>?> getGifts(String eventId) {
    return _giftFirestore.getGifts(eventId);
  }

}