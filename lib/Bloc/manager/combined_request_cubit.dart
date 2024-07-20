import 'package:bloc/bloc.dart';
import '../../../models/pending_course_model.dart';
import '../../../models/pending_beneficiary_request_model.dart';

import '../../services/Secertary Services/combined_request_service.dart';
import 'combined_request_state.dart';

class CombinedRequestCubit extends Cubit<CombinedRequestState> {
  final CombinedRequestService _service;

  CombinedRequestCubit(this._service) : super(CombinedRequestInitial());

  Future<void> fetchPendingCourses() async {
    try {
      emit(CombinedRequestLoading());
      final List<PendingRequest> pendingCourses = await _service.fetchPendingCourses();
      print("Fetched ${pendingCourses.length} courses");
      emit(CombinedRequestCoursesLoaded(pendingCourses));
    } catch (e) {
      print("Error fetching courses: $e");
      emit(CombinedRequestError(e.toString()));
    }
  }

  Future<void> fetchPendingBeneficiaries() async {
    try {
      emit(CombinedRequestLoading());
      final List<DataRequest> pendingBeneficiaries = await _service.fetchPendingBeneficiaries();
      print("Fetched ${pendingBeneficiaries.length} beneficiaries");
      emit(CombinedRequestBeneficiariesLoaded(pendingBeneficiaries));
    } catch (e) {
      print("Error fetching beneficiaries: $e");
      emit(CombinedRequestError(e.toString()));
    }
  }
}
