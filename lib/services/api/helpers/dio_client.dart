import 'package:dio/dio.dart';
import 'package:food_ai_thesis/utils/constants.dart';

class DioClient {
  static DioClient? _singleton;
  static late Dio _dio;
  static late Dio _flaskDio; // Add Dio instance for Flask API

  DioClient._() {
    _dio = createDioClient(Constants.baseUrl);
    _flaskDio = createDioClient(Constants.flaskBaseUrl); // New Dio instance
  }

  factory DioClient() => _singleton ?? DioClient._();

  Dio get instance => _dio;
  Dio get flaskInstance => _flaskDio; // Getter for Flask API

  Dio createDioClient(String baseUrl) {
    final Dio dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        receiveTimeout: const Duration(seconds: 15),
        connectTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: {
          Headers.acceptHeader: 'application/json',
          Headers.contentTypeHeader: 'application/json',
        }))
      ..options
          .headers
          .addEntries([const MapEntry('accept', 'application/json')]);

    dio.interceptors.addAll([
      LogInterceptor(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true),
    ]);

    return dio;
  }
}
