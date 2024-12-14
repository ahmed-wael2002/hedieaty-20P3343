
import '../entity/gift.dart';

abstract class GiftRepository {
  Future<GiftEntity?> fetchGift(String giftId);
  Future<void> createGifts(GiftEntity gift);
  Future<void> updateGifts(GiftEntity gift);
  Future<void> deleteGifts(GiftEntity gift);
  // Future<List<GiftEntity>?> getAllGGifts(String eventId);
  Stream<List<GiftEntity>?> getGiftsStream(String eventId);
}