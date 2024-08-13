import 'package:bloc/bloc.dart';
import '../../../models/Secertary Model/trainer_course_registration.dart';
import '../../../models/Secertary Model/trainer_model.dart';
import '../../../services/Secertary Services/trainer_services.dart';
import 'trainer_state.dart';

class TrainerCubit extends Cubit<TrainerState> {
  final TrainerService _trainerService;

  TrainerCubit(this._trainerService) : super(TrainerInitial());

  Future<void> fetchTrainers() async {
    try {
      emit(TrainerLoading());
      final trainers = await _trainerService.fetchTrainers();
      emit(TrainerLoaded(trainers));
    } catch (e) {
      emit(TrainerError(e.toString()));
    }
  }

  Future<void> fetchTrainerDetail(int id) async {
    try {
      emit(TrainerLoading());
      final trainer = await _trainerService.fetchTrainerDetail(id);
      emit(TrainerDetailLoaded(trainer));
    } catch (e) {
      emit(TrainerError(e.toString()));
    }
  }

  Future<void> deleteTrainer(int id) async {
    try {
      emit(TrainerLoading());
      await _trainerService.deleteTrainer(id);
      final trainers = await _trainerService.fetchTrainers();
      emit(TrainerLoaded(trainers));
    } catch (e) {
      emit(TrainerError(e.toString()));
    }
  }

  Future<void> updateTrainer(int id, Trainer trainer) async {
    try {
      emit(TrainerLoading());
      await _trainerService.updateTrainer(id, trainer);
      final trainers = await _trainerService.fetchTrainers();
      emit(TrainerLoaded(trainers));
    } catch (e) {
      emit(TrainerError(e.toString()));
    }
  }

  Future<void> addTrainer(Trainer trainer) async {
    try {
      emit(TrainerLoading());
      await _trainerService.addTrainer(trainer);
      final trainers = await _trainerService.fetchTrainers();
      emit(TrainerLoaded(trainers));
    } catch (e) {
      emit(TrainerError(e.toString()));
    }
  }
  Future<void> registerTrainerInCourse(int trainerId, int courseId, int countHours) async {
    try {
      emit(TrainerLoading());
      await _trainerService.registerTrainerInCourse(
        TrainerCourseRegistration(
          trainerId: trainerId,
          courseId: courseId,
          countHours: countHours,
        ),
      );
      emit(TrainerRegisteredInCourse());
      fetchTrainerDetail(trainerId);
    } catch (e) {
      emit(TrainerError(e.toString()));
    }
  }

  Future<void> searchTrainers(String query) async {
    try {
      emit(TrainerLoading());
      final trainers = await _trainerService.searchTrainers(query);
      emit(TrainerLoaded(trainers));
    } catch (e) {
      emit(TrainerError(e.toString()));
    }
  }
}