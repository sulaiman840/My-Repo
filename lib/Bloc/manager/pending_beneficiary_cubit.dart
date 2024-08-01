import 'package:bloc/bloc.dart';
import '../../models/Pending Model/pending_beneficiary_request_model.dart';
import '../../services/Manager_Services/pending_beneficiary_service.dart';
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

  Future<void> updateBeneficiary(
      int id,
      int serialNumber,
      String date,
      String province,
      String name,
      String fatherName,
      String motherName,
      String gender,
      String dateOfBirth,
      String? notes,
      String maritalStatus,
      List<Disabilities> thereIsDisbility,
      String needAttendant,
      int numberFamilyMember,
      List<Disabilities> thereIsDisbilityFamilyMember,
      String losingBreadwinner,
      String governorate,
      String address,
      String email,
      String numberLine,
      String numberPhone,
      String numberId,
      List<EducationalAttainments> educationalAttainments,
      List<PreviousTrainingCourses> previousTrainingCourses,
      List<ForeignLanguages> foreignLanguages,
      String computerDriving,
      String computerSkills,
      List<ProfessionalSkills> professionalSkills,
      String sectorPreferences,
      String employment,
      String supportRequiredTrainingLearning,
      String supportRequiredEntrepreneurship,
      String careerGuidanceCounselling,
      String generalNotes,
      ) async {
    try {
      emit(PendingBeneficiaryLoading());
      await _service.editBeneficiaryManager(
        id,
        serialNumber,
        date,
        province,
        name,
        fatherName,
        motherName,
        gender,
        dateOfBirth,
        notes,
        maritalStatus,
        thereIsDisbility,
        needAttendant,
        numberFamilyMember,
        thereIsDisbilityFamilyMember,
        losingBreadwinner,
        governorate,
        address,
        email,
        numberLine,
        numberPhone,
        numberId,
        educationalAttainments,
        previousTrainingCourses,
        foreignLanguages,
        computerDriving,
        computerSkills,
        professionalSkills,
        sectorPreferences,
        employment,
        supportRequiredTrainingLearning,
        supportRequiredEntrepreneurship,
        careerGuidanceCounselling,
        generalNotes,
      );
      fetchPendingRequests();
    } catch (e) {
      emit(PendingBeneficiaryError(e.toString()));
    }
  }
}


