import 'package:equatable/equatable.dart';
import '../../../models/Secertary Model/course_trainer_view.dart';
import '../../../models/Secertary Model/trainer_course _model.dart';

abstract class TrainerCourseState extends Equatable {
  const TrainerCourseState();

  @override
  List<Object?> get props => [];
}

class TrainerCourseInitial extends TrainerCourseState {}

class TrainerCourseLoading extends TrainerCourseState {}

class TrainerCourseLoaded extends TrainerCourseState {
  final List<TrainerCourse> trainerCourses;

  const TrainerCourseLoaded(this.trainerCourses);

  @override
  List<Object?> get props => [trainerCourses];
}

class TrainerByCourseLoaded extends TrainerCourseState {
  final List<TrainerByCourse> trainerCourses;

  const TrainerByCourseLoaded(this.trainerCourses);

  @override
  List<Object?> get props => [trainerCourses];
}

class TrainerCourseError extends TrainerCourseState {
  final String message;

  const TrainerCourseError(this.message);

  @override
  List<Object?> get props => [message];
}

class TrainerCourseDeleted extends TrainerCourseState {}
class TrainerCheckedIn extends TrainerCourseState {
  final String message;

  TrainerCheckedIn(this.message);

  @override
  List<Object?> get props => [message];
}