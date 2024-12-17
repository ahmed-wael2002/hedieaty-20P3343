import 'package:lecture_code/features/gifts/data/data_sources/local/gift_local_singleton.dart';
import 'package:lecture_code/features/gifts/data/models/gift.dart';
import 'package:lecture_code/features/gifts/domain/entity/gift.dart';
import 'package:lecture_code/features/gifts/domain/repository/gift_repository.dart';

class GiftLocalRepositoryImpl implements GiftRepository{
  final _localDatabase = GiftLocalDatabase.instance;

  @override
  Future<void> createGift(GiftEntity giftId) async {
    await _localDatabase.addGift(GiftModel.fromEntity(giftId).toMap());
  }

  @override
  Future<void> deleteGift(GiftEntity giftId) async{
    await _localDatabase.deleteGift(giftId.id);
  }

  @override
  Future<GiftEntity?> fetchGift(String giftId) async{
    final giftMap = await _localDatabase.getGiftById(giftId);
    final GiftModel giftModel = GiftModel.fromMap(giftMap!);
    return GiftEntity.fromModel(giftModel);
  }

  @override
  Future<List<GiftEntity>?> getGifts(String eventId) async{
    final List<Map<String, dynamic>> giftsMap = await _localDatabase.getAllGiftsByEventId(eventId);
    return giftsMap.map((gift) => GiftEntity.fromModel(GiftModel.fromMap(gift))).toList();
  }

  @override
  Future<List<GiftEntity>?> getPledgedGifts(String userId) async{
    final List<Map<String, dynamic>> giftsMap = await _localDatabase.getAllGiftsByUserId(userId);
    return giftsMap.map((gift) => GiftEntity.fromModel(GiftModel.fromMap(gift))).toList();
  }

  @override
  Future<void> updateGift(GiftEntity giftId) async{
    await _localDatabase.updateGift(GiftModel.fromEntity(giftId).toMap());
  }

}