import 'package:dio/dio.dart';
import 'package:lecture_code/common/constants/images_paths.dart';

class DioClient {
  static final Dio _dio = Dio();

  DioClient._internal();

  static Dio get instance {
    _dio.options = BaseOptions(
      baseUrl: 'https://api.imgur.com/3/',
      headers: {'Authorization': 'Client-ID $remoteImageClientId'},
    );
    return _dio;
  }
}
