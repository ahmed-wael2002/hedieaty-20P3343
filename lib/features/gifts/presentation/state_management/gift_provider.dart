import 'package:flutter/material.dart';
import 'package:lecture_code/features/gifts/data/repository/remote/gift_repository.dart';
import 'package:lecture_code/features/gifts/domain/usecases/fetch_gift_usecase.dart';
import 'package:lecture_code/features/gifts/domain/usecases/get_gifts_usecase.dart';
import '../../domain/entity/gift.dart';
import '../../domain/usecases/create_gift_usecase.dart';
import '../../domain/usecases/delete_gift_usecase.dart';
import '../../domain/usecases/update_gift_usecase.dart';

class GiftProvider extends ChangeNotifier{

  final _fetchGiftUsecase = FetchGiftUsecase(GiftRepositoryFirestoreImpl());
  final _getGiftsUsecase = GetGiftsUsecase(GiftRepositoryFirestoreImpl());
  final _createGiftUsecase = CreateGiftUsecase(GiftRepositoryFirestoreImpl());
  final _updateGiftUsecase = UpdateGiftUsecase(GiftRepositoryFirestoreImpl());
  final _deleteGiftUsecase = DeleteGiftUsecase(GiftRepositoryFirestoreImpl());

  // Stream<List<GiftEntity>?> getGiftsStream(String eventId) async* {
  //   yield* await _getGiftsStreamUsecase.call(params: eventId);
  // }
  Future<List<GiftEntity>?> getGifts(String eventId) async{
    try {
      return await _getGiftsUsecase.call(params: eventId);
    } catch (e) {
      debugPrint('Error fetching gifts: $e');
    }
    return null;
  }

  Future<GiftEntity?> fetchGift(String giftId) async{
    try {
      return await _fetchGiftUsecase.call(params: giftId);
    } catch (e) {
      debugPrint('Error fetching gift: $e');
    }
    return null;
  }

  Future<bool?> createGift(GiftEntity gift) async{
    try {
      await _createGiftUsecase.call(params: gift);
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error creating gift: $e');
      return false;
    }
  }

  Future<bool?> updateGift(GiftEntity gift) async{
    try {
      await _updateGiftUsecase.call(params: gift);
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error updating gift: $e');
      return false;
    }
  }

  Future<bool?> deleteGift(GiftEntity gift) async{
    try {
      await _deleteGiftUsecase.call(params: gift);
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error deleting gift: $e');
      return false;
    }
  }
}