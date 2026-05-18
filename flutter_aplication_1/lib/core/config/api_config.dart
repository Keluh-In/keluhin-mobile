class ApiConfig {
  // BASE URL
  static const String baseUrl =
      'http://127.0.0.1:8000/api';

  // AUTH
  static const String login =
      '$baseUrl/login';

  static const String register =
      '$baseUrl/register';

  static const String logout =
      '$baseUrl/logout';

  // PROFILE
  static const String profile =
      '$baseUrl/profile';

  // CATEGORY
  static const String categories =
      '$baseUrl/categories';

  // COMPLAINT
  static const String complaints =
      '$baseUrl/complaints';

  // RESPONSE
  static const String responses =
      '$baseUrl/responses';
}