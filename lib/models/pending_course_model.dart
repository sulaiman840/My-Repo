class PendingRequest {
  final int id;
  final CourseP requestPending;
  final String status;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;

  PendingRequest({
    required this.id,
    required this.requestPending,
    required this.status,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PendingRequest.fromJson(Map<String, dynamic> json) {
    return PendingRequest(
      id: json['id'] ?? 0,
      requestPending: CourseP.fromJson(json['requsetPending']),
      status: json['status'] ?? 'Unknown', // Default to 'Unknown' if null
      type: json['type'] ?? 'Unknown', // Default to 'Unknown' if null
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class CourseP {
  final String nameCourse;
  final String coursePeriod;
  final String type;
  final String courseStatus;
  final String specialty;
  final String description;

  CourseP({
    required this.nameCourse,
    required this.coursePeriod,
    required this.type,
    required this.courseStatus,
    required this.specialty,
    required this.description,
  });

  factory CourseP.fromJson(Map<String, dynamic> json) {
    return CourseP(
      nameCourse: json['nameCourse'] ?? 'Unknown',
      coursePeriod: json['coursePeriod'] ?? 'Unknown',
      type: json['type'] ?? 'Unknown',
      courseStatus: json['courseStatus'] ?? 'Unknown',
      specialty: json['specialty'] ?? 'Unknown',
      description: json['description'] ?? 'No description',
    );
  }
}
