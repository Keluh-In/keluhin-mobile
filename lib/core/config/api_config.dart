class ApiConfig {
  // BASE URL -> Tambahkan :8000 di belakang IP
  static const String baseUrl = 'https://103.169.206.213.nip.io/api';

  // AUTH
  static const String login = '$baseUrl/login';
  static const String register = '$baseUrl/register';
  static const String logout = '$baseUrl/logout';

  // PROFILE
  static const String profile = '$baseUrl/profile';

  // CATEGORY
  static const String categories = '$baseUrl/categories';

  // COMPLAINT
  static const String complaints = '$baseUrl/complaints';
  static const String complaintStats = '$baseUrl/complaints/stats';

  // RESPONSE
  static const String responses = '$baseUrl/responses';
}