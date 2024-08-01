class UpdateStaffModel {
  UpdateStaffModel({
    required this.message,
    required this.user,
  });
  late final String message;
  late final bool user;

  UpdateStaffModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['user'] = user;
    return data;
  }
}