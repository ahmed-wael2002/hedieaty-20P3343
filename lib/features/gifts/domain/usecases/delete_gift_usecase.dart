import 'package:lecture_code/features/gifts/domain/entity/gift.dart';

import '../../../../common/usecases/usecase.dart';
import '../repository/gift_repository.dart';

class DeleteGiftUsecase implements UseCase<void, GiftEntity>{
  final GiftRepository repository;

  DeleteGiftUsecase(this.repository);

  @override
  Future<void> call({GiftEntity? params}) async {
    return repository.deleteGift(params!);
  }
}