class ResponseModel {
  final int id;

  final String response;

  final String createdAt;

  final Map<String, dynamic>? admin;

  ResponseModel({
    required this.id,
    required this.response,
    required this.createdAt,
    this.admin,
  });

  factory ResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ResponseModel(
      id: json['id'] ?? 0,

      response:
          json['response'] ?? '',

      createdAt:
          json['created_at'] ?? '',

      admin: json['admin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'response': response,
      'created_at': createdAt,
      'admin': admin,
    };
  }
}