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
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['user'] = user;
    return _data;
  }
}