import 'package:lecture_code/common/usecases/usecase.dart';
import 'package:lecture_code/features/gifts/domain/entity/gift.dart';

import '../repository/gift_repository.dart';

class UpdateGiftUsecase implements UseCase<void, GiftEntity>{
  final GiftRepository repository;

  UpdateGiftUsecase(this.repository);

  @override
  Future<void> call({GiftEntity? params}) async {
    return repository.updateGift(params!);
  }
}