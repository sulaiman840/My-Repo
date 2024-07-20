import '../../../models/Secertary Model/course_model.dart';

abstract class CourseDetailState {}

class CourseDetailInitial extends CourseDetailState {}

class CourseDetailLoading extends CourseDetailState {}

class CourseDetailLoaded extends CourseDetailState {
  final Course course;

  CourseDetailLoaded(this.course);
}

class CourseDetailError extends CourseDetailState {
  final String message;

  CourseDetailError(this.message);
}
