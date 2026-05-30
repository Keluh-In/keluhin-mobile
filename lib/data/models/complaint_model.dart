class ComplaintModel {
  final int id;

  final String title;

  final String description;

  final String location;

  final String status;

  final bool isAnonymous;

  final String? attachment;

  final String createdAt;

  final Map<String, dynamic>? category;

  ComplaintModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.status,
    required this.isAnonymous,
    this.attachment,
    required this.createdAt,
    this.category,
  });

  factory ComplaintModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ComplaintModel(
      id: json['id'] ?? 0,

      title: json['title'] ?? '',

      description:
          json['description'] ?? '',

      location:
          json['location'] ?? '',

      status: json['status'] ?? '',

      isAnonymous:
          json['is_anonymous'] == 1,

      attachment:
          json['attachment'],

      createdAt:
          json['created_at'] ?? '',

      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'status': status,
      'is_anonymous': isAnonymous,
      'attachment': attachment,
      'created_at': createdAt,
      'category': category,
    };
  }
}