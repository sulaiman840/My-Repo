class GetTypeIdModel {
  GetTypeIdModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String name;
  late final String createdAt;
  late final String updatedAt;

  GetTypeIdModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}