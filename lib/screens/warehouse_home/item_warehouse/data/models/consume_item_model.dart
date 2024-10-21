class ConsumeItemModel {
  ConsumeItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.quantity,
    required this.minimumQuantity,
    required this.status,
    required this.available,
    required this.expiredDate,
    required this.typeId,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String name;
  late final String description;
  late final int quantity;
  late final int? minimumQuantity;
  late final int status;
  late final int? available;
  late final String? expiredDate;
  late final int typeId;
  late final int categoryId;
  late final String createdAt;
  late final String updatedAt;

  ConsumeItemModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    description = json['description'];
    quantity = json['quantity'];
    minimumQuantity = json['minimum_quantity'];
    status = json['status'];
    available = json['available'];
    expiredDate = json['expired_date'];
    typeId = json['type_id'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['quantity'] = quantity;
    data['minimum_quantity'] = minimumQuantity;
    data['status'] = status;
    data['available'] = available;
    data['expired_date'] = expiredDate;
    data['type_id'] = typeId;
    data['category_id'] = categoryId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}