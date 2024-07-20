class Document {
  final int id;
  final int beneficiaryId;
  final String image;
  final String filePdf;
  final DateTime createdAt;
  final DateTime updatedAt;

  Document({
    required this.id,
    required this.beneficiaryId,
    required this.image,
    required this.filePdf,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'],
      beneficiaryId: json['beneficiary_id'],
      image: json['image'],
      filePdf: json['file_pdf'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
