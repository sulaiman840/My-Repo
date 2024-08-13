import 'package:bloc/bloc.dart';
import '../../../services/Secertary Services/trainer_course_service.dart';
import 'trainer_course_state.dart';

class TrainerCourseCubit extends Cubit<TrainerCourseState> {
  final TrainerCourseService _trainerCourseService;

  TrainerCourseCubit(this._trainerCourseService)
      : super(TrainerCourseInitial());

  Future<void> fetchTrainerCourseDetail(int trainerId) async {
    try {
      emit(TrainerCourseLoading());
      final trainerCourses = await _trainerCourseService.fetchTrainerCourses(
          trainerId);
      emit(TrainerCourseLoaded(trainerCourses));
    } catch (e) {
      emit(TrainerCourseError(e.toString()));
    }
  }

  Future<void> deleteTrainerCourse(int trainerId, int courseId) async {
    try {
      emit(TrainerCourseLoading());
      await _trainerCourseService.deleteTrainerCourse(trainerId, courseId);
      emit(TrainerCourseDeleted());
      fetchTrainerCourseDetail(trainerId);
    } catch (e) {
      emit(TrainerCourseError(e.toString()));
    }
  }

  void fetchTrainersByCourse(int courseId) async {
    try {
      emit(TrainerCourseLoading());
      final trainers = await _trainerCourseService.fetchTrainersByCourse(
          courseId);
      emit(TrainerByCourseLoaded(trainers));
    } catch (e) {
      emit(TrainerCourseError(e.toString()));
    }
  }

  Future<void> checkInTrainer(int trainerId, int courseId) async {
    try {
      emit(TrainerCourseLoading());
      final message = await _trainerCourseService.checkInTrainer(trainerId, courseId);
      emit(TrainerCheckedIn(message));
    } catch (e) {
      emit(TrainerCourseError(e.toString()));
    }
  }

}