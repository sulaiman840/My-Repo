class ShowAllStaffModel {
  ShowAllStaffModel({
    required this.id,
    required this.name,
    required this.role,
    required this.email,
    required this.number,
    this.imagePath,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String name;
  late final String role;
  late final String email;
  late final String number;
  late final String? imagePath;
  late final String? emailVerifiedAt;
  late final String createdAt;
  late final String updatedAt;

  ShowAllStaffModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    role = json['role'];
    email = json['email'];
    number = json['number'];
    imagePath = json['imagePath'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['role'] = role;
    data['email'] = email;
    data['number'] = number;
    data['imagePath'] = imagePath;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}