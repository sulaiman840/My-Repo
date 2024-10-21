class DetailsReportModel {
  DetailsReportModel({
    required this.id,
    required this.title,
    required this.body,
    required this.filePath,
    required this.createdAt,
    required this.updatedAt,
  });

  late final int id;
  late final String? title;
  late final String? body;
  late final String? filePath;
  late final String createdAt;
  late final String updatedAt;

  DetailsReportModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    filePath = json['file_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['file_path'] = filePath;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
