import 'package:lecture_code/common/usecases/usecase.dart';

import '../entity/gift.dart';
import '../repository/gift_repository.dart';

class GetPledgedGiftsUseCase implements UseCase<List<GiftEntity>?, String?> {
  final GiftRepository _giftRepository;

  GetPledgedGiftsUseCase(this._giftRepository);

  @override
  Future<List<GiftEntity>?> call({String? params}) async {
    return await _giftRepository.getPledgedGifts(params!);
  }
}