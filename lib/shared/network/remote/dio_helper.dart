import 'package:dio/dio.dart';
import 'package:news/constant/constant.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic>? query,
  }) async {
    var response = await dio.get(
      url,
      queryParameters: query,
    );
    print('.......................................>>');
    print(response.statusCode);
    print(response.data);
    return response;
  }
}
