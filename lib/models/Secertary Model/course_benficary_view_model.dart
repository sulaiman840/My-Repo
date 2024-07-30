class BeneficiaryByCourse {
  final int id;
  final int beneficiaryId;
  final int courseId;
  final String status;
  final BeneficiaryDetails beneficiary;

  BeneficiaryByCourse({
    required this.id,
    required this.beneficiaryId,
    required this.courseId,
    required this.status,
    required this.beneficiary,
  });

  factory BeneficiaryByCourse.fromJson(Map<String, dynamic> json) {
    return BeneficiaryByCourse(
      id: json['id'],
      beneficiaryId: json['beneficiary_id'],
      courseId: json['course_id'],
      status: json['status'],
      beneficiary: BeneficiaryDetails.fromJson(json['beneficiary']),
    );
  }
}

class BeneficiaryDetails {
  final int id;
  final String? name;
  final String? email;
  final String? phone;

  BeneficiaryDetails({
    required this.id,
    this.name,
    this.email,
    this.phone,
  });

  factory BeneficiaryDetails.fromJson(Map<String, dynamic> json) {
    return BeneficiaryDetails(
      id: json['id'],
      name: json['name'] ?? 'N/A',
      email: json['email'] ?? 'N/A',
      phone: json['numberPhone'] ?? 'N/A',
    );
  }
}
