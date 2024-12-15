import 'package:lecture_code/common/usecases/usecase.dart';
import 'package:lecture_code/features/gifts/data/repository/remote/gift_repository.dart';
import 'package:lecture_code/features/gifts/domain/entity/gift.dart';

class GetGiftsUsecase implements UseCase<List<GiftEntity>?, String> {
  final GiftRepositoryFirestoreImpl _giftsRepository;

  GetGiftsUsecase(this._giftsRepository);

  @override
  Future<List<GiftEntity>?> call({String? params}) async {
    return await _giftsRepository.getGifts(params!);
  }
}