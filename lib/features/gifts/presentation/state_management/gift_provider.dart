import 'package:flutter/material.dart';
import 'package:lecture_code/features/gifts/data/repository/local/gift_repository.dart';
import 'package:lecture_code/features/gifts/data/repository/remote/gift_repository.dart';
import 'package:lecture_code/features/gifts/domain/usecases/fetch_gift_usecase.dart';
import 'package:lecture_code/features/gifts/domain/usecases/get_gifts_usecase.dart';
import 'package:lecture_code/features/gifts/domain/usecases/get_pledged_gifts_usecase.dart';
import 'package:lecture_code/features/gifts/domain/usecases/upload_image_usecase.dart';
import '../../domain/entity/gift.dart';
import '../../domain/usecases/create_gift_usecase.dart';
import '../../domain/usecases/delete_gift_usecase.dart';
import '../../domain/usecases/update_gift_usecase.dart';

class GiftProvider extends ChangeNotifier{
  final _uploadImageUsecase = UploadImageUsecase();

  // Remote Usecases
  final _remoteFetchGiftUsecase = FetchGiftUsecase(GiftRepositoryFirestoreImpl());
  final _remoteGetGiftsUsecase = GetGiftsUsecase(GiftRepositoryFirestoreImpl());
  final _remoteCreateGiftUsecase = CreateGiftUsecase(GiftRepositoryFirestoreImpl());
  final _remoteUpdateGiftUsecase = UpdateGiftUsecase(GiftRepositoryFirestoreImpl());
  final _remoteDeleteGiftUsecase = DeleteGiftUsecase(GiftRepositoryFirestoreImpl());
  final _remoteGetPledgedGifts = GetPledgedGiftsUseCase(GiftRepositoryFirestoreImpl());

  final _localFetchGiftUsecase = FetchGiftUsecase(GiftLocalRepositoryImpl());
  final _localGetGiftsUsecase = GetGiftsUsecase(GiftLocalRepositoryImpl());
  final _localCreateGiftUsecase = CreateGiftUsecase(GiftLocalRepositoryImpl());
  final _localUpdateGiftUsecase = UpdateGiftUsecase(GiftLocalRepositoryImpl());
  final _localDeleteGiftUsecase = DeleteGiftUsecase(GiftLocalRepositoryImpl());
  final _localGetPledgedGifts = GetPledgedGiftsUseCase(GiftLocalRepositoryImpl());

  Future<List<GiftEntity>?> getPledgedGifts({required String userId, required bool isRemote}) async{
    try {
      if(isRemote){
        return await _remoteGetPledgedGifts.call(params: userId);
      }
      return await _localGetPledgedGifts.call(params: userId);
    } catch (e) {
      debugPrint('Error fetching pledged gifts: $e');
    }
    return null;
  }

  Future<List<GiftEntity>?> getGifts({required String eventId, required bool isRemote}) async{
    try {
      if(isRemote){
        return await _remoteGetGiftsUsecase.call(params: eventId);
      }
      return await _localGetGiftsUsecase.call(params: eventId);
    } catch (e) {
      debugPrint('Error fetching gifts: $e');
    }
    return null;
  }

  Future<GiftEntity?> fetchGift({required String giftId, required bool isRemote}) async{
    try {
      if(isRemote){
        return await _remoteFetchGiftUsecase.call(params: giftId);
      }
      return await _localFetchGiftUsecase.call(params: giftId);
    } catch (e) {
      debugPrint('Error fetching gift: $e');
    }
    return null;
  }

  Future<bool?> createGift({required GiftEntity gift, required bool isRemote}) async{
    try {
      if(isRemote){
        await _remoteCreateGiftUsecase.call(params: gift);
      }
      else{
        await _localCreateGiftUsecase.call(params: gift);
      }
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error creating gift: $e');
      return false;
    }
  }

  Future<bool?> updateGift({required GiftEntity gift, required bool isRemote}) async{
    try {
      if(isRemote){
        await _remoteUpdateGiftUsecase.call(params: gift);
      }
      else{
        await _localUpdateGiftUsecase.call(params: gift);
      }
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error updating gift: $e');
      return false;
    }
  }

  Future<String?> uploadImage(){
    return _uploadImageUsecase();
  }

  Future<bool?> deleteGift({required GiftEntity gift, required bool isRemote}) async{
    try {
      if(isRemote){
        await _remoteDeleteGiftUsecase.call(params: gift);
      }
      else{
        await _localDeleteGiftUsecase.call(params: gift);
      }
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error deleting gift: $e');
      return false;
    }
  }
}