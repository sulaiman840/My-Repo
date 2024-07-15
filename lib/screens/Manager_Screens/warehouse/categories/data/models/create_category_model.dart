class CreateCategoryModel {
  CreateCategoryModel({
    required this.name,
    required this.parentId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });
  late final String name;
  late final int? parentId;
  late final String updatedAt;
  late final String createdAt;
  late final int id;

  CreateCategoryModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    parentId = json['parent_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['parent_id'] = parentId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}