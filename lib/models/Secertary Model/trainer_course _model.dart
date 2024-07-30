import 'package:project2/models/Secertary%20Model/trainer_model.dart';

import 'course_model.dart';

class TrainerCourse {
  final int id;
  final int countHours;
  final int trainerId;
  final int courseId;
  final Course course;

  TrainerCourse({
    required this.id,
    required this.countHours,
    required this.trainerId,
    required this.courseId,
    required this.course,

  });

  factory TrainerCourse.fromJson(Map<String, dynamic> json) {
    return TrainerCourse(
      id: json['id'],
      countHours: json['countHours'],
      trainerId: json['trainer_id'],
      courseId: json['course_id'],
      course: Course.fromJson(json['course']),
    );
  }
}
