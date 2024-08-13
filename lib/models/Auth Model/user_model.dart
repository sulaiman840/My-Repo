class UserModel {
  final int id;
  final String name;
  final String role;
  final String email;
  final String number;
  final String? imagePath;
  final String fcmToken;
  final String createdAt;
  final String updatedAt;
  final String token;
  final String emailVerifiedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.role,
    required this.email,
    required this.number,
     this.imagePath,
    required this.fcmToken,
    required this.createdAt,
    required this.updatedAt,
    required this.token,
    required this.emailVerifiedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      role: json['role'],
      email: json['email'],
      number: json['number'],
      imagePath: json['imagePath']?? '',
      fcmToken: json['fcm_token'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      token: json['_token'],
      emailVerifiedAt: json['email_verified_at'] ?? '',
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
      'fcm_token': fcmToken,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'token': token,
      'email_verified_at': emailVerifiedAt,
    };
  }
}
