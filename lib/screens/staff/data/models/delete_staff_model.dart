class DeleteStaffModel {
  DeleteStaffModel({
    required this.message,
  });
  late final String message;

  DeleteStaffModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    return _data;
  }
}