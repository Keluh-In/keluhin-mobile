import 'package:dio/dio.dart';

import '../../core/config/api_config.dart';
import '../../core/utils/storage.dart';

class ComplaintService {
  final Dio dio = Dio();

  // GET COMPLAINTS
  Future<List> getComplaints() async {
    try {
      final token =
          await Storage.getToken();

      final response = await dio.get(
        ApiConfig.complaints,

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

  // STATS
  Future<Map<String, dynamic>> getStats() async {
    try {
      final token =
          await Storage.getToken();

      final response = await dio.get(
        ApiConfig.complaintStats,

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

  // DETAIL
  Future<Map<String, dynamic>>
  getComplaintDetail(int id) async {
    try {
      final token =
          await Storage.getToken();

      final response = await dio.get(
        '${ApiConfig.complaints}/$id',

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

  // CREATE
  Future<bool> createComplaint({
    required String title,
    required String description,
    required int categoryId,
    required String location,
    required bool isAnonymous,
    String? attachment,
  }) async {
    try {
      final token =
          await Storage.getToken();

      FormData formData =
          FormData.fromMap({
        'title': title,
        'description': description,
        'category_id': categoryId,
        'location': location,
        'is_anonymous':
            isAnonymous ? 1 : 0,

        if (attachment != null)
          'image':
              await MultipartFile.fromFile(
                attachment,
              ),
      });

      await dio.post(
        ApiConfig.complaints,

        data: formData,

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

  // UPDATE
  Future<bool> updateComplaint({
    required int id,
    required String title,
    required String description,
    required int categoryId,
    required String location,
    String? attachment,
  }) async {
    try {
      final token =
          await Storage.getToken();

      // Method spoofing: Laravel tidak mem-parse file pada PUT multipart,
      // jadi kirim POST + _method=PUT.
      FormData formData =
          FormData.fromMap({
        'title': title,
        'description': description,
        'category_id': categoryId,
        'location': location,
        '_method': 'PUT',

        if (attachment != null)
          'image':
              await MultipartFile.fromFile(
                attachment,
              ),
      });

      await dio.post(
        '${ApiConfig.complaints}/$id',

        data: formData,

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

  // DELETE
  Future<bool> deleteComplaint(
    int id,
  ) async {
    try {
      final token =
          await Storage.getToken();

      await dio.delete(
        '${ApiConfig.complaints}/$id',

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

  // RESPONSES
  Future<List> getResponses(
    int complaintId,
  ) async {
    try {
      final token =
          await Storage.getToken();

      final response = await dio.get(
        '${ApiConfig.complaints}/$complaintId/responses',

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