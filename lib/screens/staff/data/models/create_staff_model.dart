class CreateStaffModel {
  CreateStaffModel({
    required this.message,
    required this.user,
  });
  late final String message;
  late final User user;

  CreateStaffModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['user'] = user.toJson();
    return data;
  }
}

class User {
  User({
    required this.name,
    required this.role,
    required this.email,
    required this.number,
    required this.imagePath,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });
  late final String name;
  late final String role;
  late final String email;
  late final String number;
  late final String imagePath;
  late final String updatedAt;
  late final String createdAt;
  late final int id;

  User.fromJson(Map<String, dynamic> json){
    name = json['name'];
    role = json['role'];
    email = json['email'];
    number = json['number'];
    imagePath = json['imagePath'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['role'] = role;
    data['email'] = email;
    data['number'] = number;
    data['imagePath'] = imagePath;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}