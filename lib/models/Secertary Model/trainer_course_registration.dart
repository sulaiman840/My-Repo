class TrainerCourseRegistration {
  int? id;
  final int countHours;
  final int trainerId;
  final int courseId;
  Course? course;

  TrainerCourseRegistration({
     this.id,
    required this.countHours,
    required this.trainerId,
    required this.courseId,
    this.course,
  });

  factory TrainerCourseRegistration.fromJson(Map<String, dynamic> json) {
    return TrainerCourseRegistration(
      id: json['id'],
      countHours: json['countHours'],
      trainerId: json['trainer_id'],
      courseId: json['course_id'],
      course: Course.fromJson(json['course']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'countHours': countHours,
      'trainer_id': trainerId,
      'course_id': courseId,
      'course': course?.toJson(),
    };
  }
}

class Course {
  final int id;
  final String nameCourse;
  final String coursePeriod;
  final String type;
  final String courseStatus;
  final String specialty;
  final String description;

  Course({
    required this.id,
    required this.nameCourse,
    required this.coursePeriod,
    required this.type,
    required this.courseStatus,
    required this.specialty,
    required this.description,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      nameCourse: json['nameCourse'],
      coursePeriod: json['coursePeriod'],
      type: json['type'],
      courseStatus: json['courseStatus'],
      specialty: json['specialty'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameCourse': nameCourse,
      'coursePeriod': coursePeriod,
      'type': type,
      'courseStatus': courseStatus,
      'specialty': specialty,
      'description': description,
    };
  }
}
