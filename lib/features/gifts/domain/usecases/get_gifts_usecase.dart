import 'package:lecture_code/common/usecases/usecase.dart';
import 'package:lecture_code/features/gifts/domain/entity/gift.dart';
import 'package:lecture_code/features/gifts/domain/repository/gift_repository.dart';

class GetGiftsUsecase implements UseCase<List<GiftEntity>?, String> {
  final GiftRepository _giftsRepository;

  GetGiftsUsecase(this._giftsRepository);

  @override
  Future<List<GiftEntity>?> call({String? params}) async {
    return await _giftsRepository.getGifts(params!);
  }
}