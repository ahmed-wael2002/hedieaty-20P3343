
import '../entity/gift.dart';

abstract class GiftRepository {
  Future<GiftEntity?> fetchGift(String giftId);
  Future<void> createGift(GiftEntity giftId);
  Future<void> updateGift(GiftEntity giftId);
  Future<void> deleteGift(GiftEntity giftId);
  // Future<List<GiftEntity>?> getAllGGifts(String eventId);
  Future<List<GiftEntity>?> getGifts(String eventId);
  Future<List<GiftEntity>?> getPledgedGifts(String userId);
}