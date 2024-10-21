class UserProfile {
  final int id;
  final String name;
  final String role;
  final String email;
  final String number;
  final String? imagePath;
  final String? emailVerifiedAt;
  final String fcmToken;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfile({
    required this.id,
    required this.name,
    required this.role,
    required this.email,
    required this.number,
    this.imagePath,
    this.emailVerifiedAt,
    required this.fcmToken,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      name: json['name'],
      role: json['role'],
      email: json['email'],
      number: json['number'],
      imagePath: json['imagePath'],
      emailVerifiedAt: json['email_verified_at'],
      fcmToken: json['fcm_token'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'email': email,
      'number': number,
      'imagePath': imagePath,
      'email_verified_at': emailVerifiedAt,
      'fcm_token': fcmToken,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
