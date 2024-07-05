class CreateTypeModel {
  CreateTypeModel({
    required this.name,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });
  late final String name;
  late final String updatedAt;
  late final String createdAt;
  late final int id;

  CreateTypeModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}

class DeleteTypeModel {

}