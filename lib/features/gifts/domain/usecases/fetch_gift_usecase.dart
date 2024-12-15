import '../../../../common/usecases/usecase.dart';
import '../entity/gift.dart';
import '../repository/gift_repository.dart';

class FetchGiftUsecase implements UseCase<GiftEntity?, String> {
  final GiftRepository _giftRepository;

  FetchGiftUsecase(this._giftRepository);

  @override
  Future<GiftEntity?> call({String? params}) {
    return _giftRepository.fetchGift(params!);
  }
}