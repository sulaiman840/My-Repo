class TrainerByCourse {
  final int id;
  final int countHours;
  final int trainerId;
  final int courseId;
  final TrainerDetails trainer;

  TrainerByCourse({
    required this.id,
    required this.countHours,
    required this.trainerId,
    required this.courseId,
    required this.trainer,
  });

  factory TrainerByCourse.fromJson(Map<String, dynamic> json) {
    return TrainerByCourse(
      id: json['id'],
      countHours: json['countHours'],
      trainerId: json['trainer_id'],
      courseId: json['course_id'],
      trainer: TrainerDetails.fromJson(json['trainer']),
    );
  }
}

class TrainerDetails {
  final int id;
  final String name;
  final String email;
  final String phone;

  TrainerDetails({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory TrainerDetails.fromJson(Map<String, dynamic> json) {
    return TrainerDetails(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}
