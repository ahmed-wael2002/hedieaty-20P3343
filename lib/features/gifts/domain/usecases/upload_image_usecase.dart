import 'package:lecture_code/common/usecases/usecase.dart';
import 'package:lecture_code/features/gifts/data/data_sources/network/imgur_image_uploader.dart';

class UploadImageUsecase implements UseCase<String?, void>{
  @override
  Future<String?> call({void params}) async{
    return await ImgurUploader().uploadImageToImgur();
  }
}