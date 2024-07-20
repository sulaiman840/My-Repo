import 'package:bloc/bloc.dart';
import '../../../models/Secertary Model/course_model.dart';
import '../../../services/Secertary Services/course_service.dart';
import 'course_detail_state.dart';

class CourseDetailCubit extends Cubit<CourseDetailState> {
  final CourseService _courseService;

  CourseDetailCubit(this._courseService) : super(CourseDetailInitial());

  Future<void> fetchCourseDetail(int id) async {
    try {
      emit(CourseDetailLoading());
      final course = await _courseService.fetchCourseDetail(id);
      emit(CourseDetailLoaded(course));
    } catch (e) {
      emit(CourseDetailError(e.toString()));
    }
  }
}
