import 'package:bloc/bloc.dart';

import '../../services/Manager_Services/pending_courses_service.dart';
import 'pending_course_state.dart';

class PendingRequestCubit extends Cubit<PendingRequestState> {
  final PendingRequestService _pendingRequestService;

  PendingRequestCubit(this._pendingRequestService) : super(PendingRequestInitial());

  Future<void> fetchPendingRequests() async {
    try {
      emit(PendingRequestLoading());
      final pendingRequests = await _pendingRequestService.fetchPendingRequests();
      emit(PendingRequestLoaded(pendingRequests));
    } catch (e) {
      emit(PendingRequestError(e.toString()));
    }
  }

  Future<void> approveRequest(int id) async {
    try {
      await _pendingRequestService.approveRequest(id);
      fetchPendingRequests();
    } catch (e) {
      emit(PendingRequestError(e.toString()));
    }
  }

  Future<void> rejectRequest(int id) async {
    try {
      await _pendingRequestService.rejectRequest(id);
      fetchPendingRequests();
    } catch (e) {
      emit(PendingRequestError(e.toString()));
    }
  }
}
