class AllReportModel {
  AllReportModel({
    required this.currentPage,
    required this.dataReport,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  late final int currentPage;
  late final List<DataReport>? dataReport;
  late final String firstPageUrl;
  late final int? from;
  late final int lastPage;
  late final String lastPageUrl;
  late final List<Links> links;
  late final String? nextPageUrl;
  late final String path;
  late final int perPage;
  late final String? prevPageUrl;
  late final int? to;
  late final int total;

  AllReportModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    dataReport = List.from(json['data']).map((e)=>DataReport.fromJson(e)).toList();
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    links = List.from(json['links']).map((e)=>Links.fromJson(e)).toList();
    nextPageUrl = null;
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = null;
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['data'] = dataReport!.map((e)=>e.toJson()).toList();
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    data['links'] = links.map((e)=>e.toJson()).toList();
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class DataReport {
  DataReport({
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

  DataReport.fromJson(Map<String, dynamic> json) {
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

class Links {
  Links({
    this.url,
    required this.label,
    required this.active,
  });
  late final String? url;
  late final String label;
  late final bool active;

  Links.fromJson(Map<String, dynamic> json){
    url = null;
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}