import '../services/profile_service.dart';

class ProfileRepository {
  final ProfileService service =
      ProfileService();

  // GET PROFILE
  Future<Map<String, dynamic>>
  getProfile() async {
    return await service.getProfile();
  }

  // UPDATE PROFILE
  Future<bool> updateProfile({
    required String name,
    required String email,
    String? password,
  }) async {
    return await service.updateProfile(
      name: name,
      email: email,
      password: password,
    );
  }
}