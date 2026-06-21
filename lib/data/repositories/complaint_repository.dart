import '../models/complaint_stats_model.dart';
import '../services/complaint_service.dart';

class ComplaintRepository {
  final ComplaintService service =
      ComplaintService();

  // GET ALL
  Future<List> getComplaints() async {
    return await service.getComplaints();
  }

  // STATS
  Future<ComplaintStatsModel> getStats() async {
    final data = await service.getStats();
    return ComplaintStatsModel.fromJson(data);
  }

  // DETAIL
  Future<Map<String, dynamic>>
  getComplaintDetail(int id) async {
    return await service
        .getComplaintDetail(id);
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
    return await service.createComplaint(
      title: title,
      description: description,
      categoryId: categoryId,
      location: location,
      isAnonymous: isAnonymous,
      attachment: attachment,
    );
  }

  // UPDATE
  Future<bool> updateComplaint({
    required int id,
    required String title,
    required String description,
    required int categoryId,
    required String location,
  }) async {
    return await service.updateComplaint(
      id: id,
      title: title,
      description: description,
      categoryId: categoryId,
      location: location,
    );
  }

  // DELETE
  Future<bool> deleteComplaint(
    int id,
  ) async {
    return await service
        .deleteComplaint(id);
  }

  // RESPONSES
  Future<List> getResponses(
    int complaintId,
  ) async {
    return await service.getResponses(
      complaintId,
    );
  }
}