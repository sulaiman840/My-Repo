import 'package:bloc/bloc.dart';
import '../../services/Manager_Services/pending_trainer_service.dart';

import 'pending_trainer_state.dart';

class PendingTrainerCubit extends Cubit<PendingTrainerState> {
  final PendingTrainerService _pendingTrainerService;

  PendingTrainerCubit(this._pendingTrainerService) : super(PendingTrainerInitial());

  Future<void> fetchPendingTrainers() async {
    try {
      emit(PendingTrainerLoading());
      final pendingTrainers = await _pendingTrainerService.fetchPendingTrainers();
      emit(PendingTrainerLoaded(pendingTrainers));
    } catch (e) {
      emit(PendingTrainerError(e.toString()));
    }
  }
  Future<void> approveRequest(int id) async {
    try {
      await _pendingTrainerService.approveRequest(id);
      fetchPendingTrainers();
    } catch (e) {
      emit(PendingTrainerError(e.toString()));
    }
  }

  Future<void> rejectRequest(int id) async {
    try {
      await _pendingTrainerService.rejectRequest(id);
      fetchPendingTrainers();

    } catch (e) {
      emit(PendingTrainerError(e.toString()));
    }
  }

}
