import 'package:dio/dio.dart';

import '../../core/config/api_config.dart';
import '../../core/utils/storage.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,

      connectTimeout:
          const Duration(seconds: 30),

      receiveTimeout:
          const Duration(seconds: 30),

      headers: {
        'Accept':
            'application/json',
      },
    ),
  );

  static Future<void> init() async {
    dio.interceptors.clear();

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (
              options,
              handler,
            ) async {
              final token =
                  await Storage.getToken();

              if (token != null) {
                options.headers[
                        'Authorization'] =
                    'Bearer $token';
              }

              return handler.next(
                options,
              );
            },

        onError: (
          error,
          handler,
        ) {
          return handler.next(error);
        },
      ),
    );
  }
}