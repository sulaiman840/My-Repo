class AcceptRequestModel {
  AcceptRequestModel({
    required this.error,
  });
  late final String error;

  AcceptRequestModel.fromJson(Map<String, dynamic> json){
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['error'] = error;
    return data;
  }
}