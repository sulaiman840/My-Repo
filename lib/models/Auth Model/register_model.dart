class User {
  final String name;
  final String email;
  final String number;
  final String password;
  final String role;
  final String imagePath;

  User({
    required this.name,
    required this.email,
    required this.number,
    required this.password,
    required this.role,
    required this.imagePath,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      email: json['email'] as String,
      number: json['number'] as String,
      password: json['password'] as String? ?? '',
      role: json['role'] as String,
      imagePath: json['imagePath'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'number': number,
      'password': password,
      'role': role,
      'imagePath': imagePath,
    };
  }
}
