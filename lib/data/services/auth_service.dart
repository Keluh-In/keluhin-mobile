import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../core/config/api_config.dart';
import '../../core/utils/storage.dart';

class AuthService {
  final Dio dio = Dio();

  // ==========================================
  // FUNGSI LOGIN
  // ==========================================
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      if (kDebugMode) {
        debugPrint('LOGIN START');
      }

      final response = await dio.post(
        ApiConfig.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      // Mengambil token dari response JSON Laravel (Struktur: data -> token)
      final token = response.data['data']['token'];

      if (kDebugMode) {
        debugPrint('LOGIN SUCCESS. TOKEN: $token');
      }

      // Menyimpan token ke penyimpanan lokal (Shared Preferences / Secure Storage)
      await Storage.saveToken(token);

      return true;
    } on DioException catch (e) {
      if (kDebugMode) {
        debugPrint('LOGIN DIO ERROR');
        debugPrint('Status Code: ${e.response?.statusCode}');
        debugPrint('Response Data: ${e.response?.data}');
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('LOGIN ERROR');
        debugPrint(e.toString());
      }
      return false;
    }
  }

  // ==========================================
  // FUNGSI REGISTER
  // ==========================================
  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      if (kDebugMode) {
        debugPrint('REGISTER START');
      }

      final response = await dio.post(
        ApiConfig.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': password, // Mengisi password konfirmasi otomatis sama dengan password
        },
      );

      // Otomatis mengambil token dari register jika ingin langsung masuk ke halaman utama setelah daftar
      final token = response.data['data']['token'];

      if (kDebugMode) {
        debugPrint('REGISTER SUCCESS. TOKEN: $token');
      }

      // Menyimpan token pendaftaran ke penyimpanan lokal
      await Storage.saveToken(token);

      return true;
    } on DioException catch (e) {
      if (kDebugMode) {
        debugPrint('REGISTER DIO ERROR');
        debugPrint(e.message);
        debugPrint('Status Code: ${e.response?.statusCode}');
        debugPrint('Response Data: ${e.response?.data}');
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('REGISTER ERROR');
        debugPrint(e.toString());
      }
      return false;
    }
  }

  // ==========================================
  // FUNGSI LOGOUT
  // ==========================================
  Future<void> logout() async {
    await Storage.logout();
    if (kDebugMode) {
      debugPrint('LOGOUT SUCCESS (Token Cleared)');
    }
  }
}