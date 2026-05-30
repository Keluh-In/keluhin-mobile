import 'package:dio/dio.dart';

import '../../core/config/api_config.dart';
import '../../core/utils/storage.dart';

class ProfileService {
  final Dio dio = Dio();

  // PROFILE
  Future<Map<String, dynamic>>
  getProfile() async {
    try {
      final token =
          await Storage.getToken();

      final response = await dio.get(
        ApiConfig.profile,

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

  // UPDATE
  Future<bool> updateProfile({
    required String name,
    required String email,
    String? password,
  }) async {
    try {
      final token =
          await Storage.getToken();

      Map<String, dynamic> data = {
        'name': name,
        'email': email,
      };

      if (password != null &&
          password.isNotEmpty) {
        data['password'] = password;
      }

      await dio.put(
        ApiConfig.profile,

        data: data,

        options: Options(
          headers: {
            'Authorization':
                'Bearer $token',
          },
        ),
      );

      return true;
    } catch (e) {
      return false;
    }
  }
}