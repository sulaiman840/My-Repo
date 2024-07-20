import 'package:bloc/bloc.dart';
import '../../../models/pending_beneficiary_request_model.dart';
import '../../../services/Secertary Services/pending_beneficiary_service.dart';
import 'pending_beneficiary_state.dart';

class PendingBeneficiaryCubit extends Cubit<PendingBeneficiaryState> {
  final PendingBeneficiaryService _service;

  PendingBeneficiaryCubit(this._service) : super(PendingBeneficiaryInitial());

  Future<void> fetchPendingRequests() async {
    try {
      emit(PendingBeneficiaryLoading());
      final List<DataRequest> pendingRequests = await _service.fetchPendingRequests();
      emit(PendingBeneficiaryLoaded(pendingRequests));
    } catch (e) {
      emit(PendingBeneficiaryError(e.toString()));
    }
  }

  Future<void> approveRequest(int id) async {
    try {
      await _service.approveRequest(id);
      fetchPendingRequests();
    } catch (e) {
      emit(PendingBeneficiaryError(e.toString()));
    }
  }

  Future<void> rejectRequest(int id) async {
    try {
      await _service.rejectRequest(id);
      fetchPendingRequests();
    } catch (e) {
      emit(PendingBeneficiaryError(e.toString()));
    }
  }
}
