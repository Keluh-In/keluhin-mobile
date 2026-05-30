import '../services/auth_service.dart';

class AuthRepository {
  final AuthService service =
      AuthService();

  // LOGIN
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    return await service.login(
      email: email,
      password: password,
    );
  }

  // REGISTER
  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    return await service.register(
      name: name,
      email: email,
      password: password,
    );
  }

  // LOGOUT
  Future<void> logout() async {
    await service.logout();
  }
}