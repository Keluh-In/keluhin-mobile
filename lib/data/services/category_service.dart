import 'package:dio/dio.dart';

import '../../core/config/api_config.dart';
import '../../core/utils/storage.dart';

class CategoryService {
  final Dio dio = Dio();

  Future<List> getCategories() async {
    try {
      final token =
          await Storage.getToken();

      final response = await dio.get(
        ApiConfig.categories,

        options: Options(
          headers: {
            'Authorization':
                'Bearer $token',
          },
        ),
      );

      return response.data['data'];
    } catch (e) {
      rethrow;
    }
  }
}