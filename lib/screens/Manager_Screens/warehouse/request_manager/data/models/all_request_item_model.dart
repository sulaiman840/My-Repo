class AllRequestItemModel {
  AllRequestItemModel({
    required this.message,
    required this.dataRequestItem,
  });
  late final String message;
  late final List<DataRequestItem>? dataRequestItem;

  AllRequestItemModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    dataRequestItem = List.from(json['dataRequest']).map((e)=>DataRequestItem.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['dataRequest'] = dataRequestItem!.map((e)=>e.toJson()).toList();
    return data;
  }
}

class DataRequestItem {
  DataRequestItem({
    required this.id,
    required this.requsetPending,
    required this.status,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String requsetPending;
  late final String status;
  late final String type;
  late final String createdAt;
  late final String updatedAt;

  DataRequestItem.fromJson(Map<String, dynamic> json){
    id = json['id'];
    requsetPending = json['requsetPending'];
    status = json['status'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['requsetPending'] = requsetPending;
    data['status'] = status;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}