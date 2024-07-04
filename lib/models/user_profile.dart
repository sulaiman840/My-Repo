class UserProfile {
  final int id;
  final String name;
  final String type;
  final String email;
  final int number;
  final String? imagePath;
  final String? emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfile({
    required this.id,
    required this.name,
    required this.type,
    required this.email,
    required this.number,
    this.imagePath,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      email: json['email'],
      number: json['number'],
      imagePath: json['imagePath'],
      emailVerifiedAt: json['email_verified_at'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
