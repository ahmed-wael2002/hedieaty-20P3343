import 'package:lecture_code/common/usecases/usecase.dart';
import 'package:lecture_code/features/events/domain/entity/event.dart';
import 'package:lecture_code/features/events/domain/repository/event_repository.dart';
import 'package:lecture_code/features/gifts/domain/entity/gift.dart';

class AddGiftParams {
  final EventEntity event;
  final GiftEntity gift;

  AddGiftParams({required this.event, required this.gift});
}

class AddGiftUsecase implements UseCase<bool, AddGiftParams> {
  final EventRepository _giftRepository;

  AddGiftUsecase(this._giftRepository);

  @override
  Future<bool> call({AddGiftParams? params}) async {
    try {
      await _giftRepository.addGift(params!.event, params.gift);
      return true;
    } catch (e) {
      return false;
    }
  }
}