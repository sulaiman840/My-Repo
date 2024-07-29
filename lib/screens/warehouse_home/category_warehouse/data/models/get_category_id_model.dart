class GetCategoryIdModel {
  GetCategoryIdModel({
    required this.id,
    required this.name,
    this.reqiestedName,
    required this.available,
    this.parentId,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String name;
  late final String? reqiestedName;
  late final int available;
  late final int? parentId;
  late final String createdAt;
  late final String updatedAt;

  GetCategoryIdModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    reqiestedName = json['reqiestedName'];
    available = json['available'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['reqiestedName'] = reqiestedName;
    data['available'] = available;
    data['parent_id'] = parentId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}