import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../core/config/api_config.dart';
import '../../core/utils/storage.dart';

class AuthService {
  final Dio dio = Dio();

  // =========================
  // LOGIN
  // =========================
Future<bool> login({
  required String email,
  required String password,
}) async {
  try {
    final response = await dio.post(
      ApiConfig.login,
      data: {
        'email': email,
        'password': password,
      },
    );

    print('LOGIN RESPONSE:');
    print(response.data);

    final token =
        response.data['data']['token'];

    print('TOKEN: $token');

    await Storage.saveToken(token);

    return true;
  } on DioException catch (e) {
    print('LOGIN DIO ERROR');

    print(e.response?.statusCode);

    print(e.response?.data);

    return false;
  } catch (e) {
    print('LOGIN ERROR');

    print(e);

    return false;
  }
}

  // =========================
  // REGISTER
  // =========================
  Future<bool> register({
  required String name,
  required String email,
  required String password,
}) async {
  try {
    if (kDebugMode) {
      print('REGISTER START');
    }

    final response = await dio.post(
      ApiConfig.register,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation':
            password,
      },
    );

    if (kDebugMode) {
      print('SUCCESS');
    }
    if (kDebugMode) {
      print(response.data);
    }

    return true;
  } on DioException catch (e) {
    if (kDebugMode) {
      print('DIO ERROR');
    }

    if (kDebugMode) {
      print(e.message);
    }

    if (kDebugMode) {
      print(e.response?.statusCode);
    }

    if (kDebugMode) {
      print(e.response?.data);
    }

    return false;
  } catch (e) {
    if (kDebugMode) {
      print('ERROR');
    }

    if (kDebugMode) {
      print(e);
    }

    return false;
  }
}

  // =========================
  // LOGOUT
  // =========================
  Future<void> logout() async {
    await Storage.logout();
  }
}