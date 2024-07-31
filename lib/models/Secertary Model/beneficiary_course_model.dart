import 'course_model.dart';

class BeneficiaryCourse {
  final int id;
  final int beneficiaryId;
  final int courseId;
  final String status;
  final Course course;

  BeneficiaryCourse({
    required this.id,
    required this.beneficiaryId,
    required this.courseId,
    required this.status,
    required this.course,
  });

  factory BeneficiaryCourse.fromJson(Map<String, dynamic> json) {
    return BeneficiaryCourse(
      id: json['id'],
      beneficiaryId: json['beneficiary_id'],
      courseId: json['course_id'],
      status: json['status'],
      course: Course.fromJson(json['course']),
    );
  }
}
