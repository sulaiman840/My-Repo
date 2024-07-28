import 'package:bloc/bloc.dart';
import '../../../models/Secertary Model/course_model.dart';
import '../../../services/Secertary Services/course_service.dart';

import 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  final CourseService _courseService;

  CourseCubit(this._courseService) : super(CourseInitial());

  Future<void> fetchCourses() async {
    try {
      emit(CourseLoading());
      final courses = await _courseService.fetchCourses();
      emit(CourseLoaded(courses));
    } catch (e) {
      emit(CourseError(e.toString()));
    }
  }

  Future<void> deleteCourse(int id) async {
    try {
      emit(CourseLoading());
      await _courseService.deleteCourse(id);
      final courses = await _courseService.fetchCourses();
      emit(CourseLoaded(courses));
    } catch (e) {
      emit(CourseError(e.toString()));
    }
  }

  Future<void> updateCourse(int id, Course course) async {
    try {
      emit(CourseLoading());
      await _courseService.updateCourse(id, course);
      final courses = await _courseService.fetchCourses();
      emit(CourseLoaded(courses));
    } catch (e) {
      emit(CourseError(e.toString()));
    }
  }

  Future<void> addCourse(Course course) async {
    try {
      emit(CourseLoading());
      await _courseService.addCourse(course);
      final courses = await _courseService.fetchCourses();
      emit(CourseLoaded(courses));
    } catch (e) {
      emit(CourseError(e.toString()));
    }
  }
}
