class RejectRequestModel {
  RejectRequestModel({
    required this.error,
  });
  late final String error;

  RejectRequestModel.fromJson(Map<String, dynamic> json){
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['error'] = error;
    return data;
  }
}