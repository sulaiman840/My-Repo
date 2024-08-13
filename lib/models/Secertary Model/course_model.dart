class Course {
  final int id;
  final String nameCourse;
  final int coursePeriod;
  final String sessionDuration;
  final String? sessionsGiven;
  final String type;
  final String courseStatus;
  final String specialty;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  Course({
    required this.id,
    required this.nameCourse,
    required this.coursePeriod,
    required this.sessionDuration,
     this.sessionsGiven,
    required this.type,
    required this.courseStatus,
    required this.specialty,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      nameCourse: json['nameCourse'],
      coursePeriod: json['coursePeriod'],
      sessionDuration: json['sessionDoration'],
      sessionsGiven:json['sessionsGiven'],
      type: json['type'],
      courseStatus: json['courseStatus'],
      specialty: json['specialty'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameCourse': nameCourse,
      'coursePeriod': coursePeriod,
      'sessionDoration': sessionDuration,
      'sessionsGiven': sessionsGiven,
      'type': type,
      'courseStatus': courseStatus,
      'specialty': specialty,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
