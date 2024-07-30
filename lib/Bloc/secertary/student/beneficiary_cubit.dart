import 'package:bloc/bloc.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';
import '../../../services/Secertary Services/beneficiary_service.dart';
import 'beneficiary_state.dart';

class BeneficiaryCubit extends Cubit<BeneficiaryState> {
  final BeneficiaryService _beneficiaryService;

  BeneficiaryCubit(this._beneficiaryService) : super(BeneficiaryInitial());

  Future<void> fetchBeneficiaries() async {
    try {
      emit(BeneficiaryLoading());
      final beneficiaries = await _beneficiaryService.fetchBeneficiaries();
      emit(BeneficiaryLoaded(beneficiaries));
    } catch (e) {
      emit(BeneficiaryError(e.toString()));
    }
  }

  Future<void> updateBeneficiary(DataBeneficiary beneficiary) async {
    try {
      emit(BeneficiaryLoading());
      await _beneficiaryService.updateBeneficiary(
        beneficiary.id!,
        beneficiary.serialNumber!,
        beneficiary.date!,
        beneficiary.province!,
        beneficiary.name!,
        beneficiary.fatherName!,
        beneficiary.motherName!,
        beneficiary.gender!,
        beneficiary.dateOfBirth!,
        beneficiary.nots!,
        beneficiary.maritalStatus!,
        beneficiary.thereIsDisbility!,
        beneficiary.needAttendant!,
        beneficiary.numberFamilyMember!,
        beneficiary.thereIsDisbilityFamilyMember!,
        beneficiary.losingBreadwinner!,
        beneficiary.governorate!,
        beneficiary.address!,
        beneficiary.email!,
        beneficiary.numberLine!,
        beneficiary.numberPhone!,
        beneficiary.numberId!,
        beneficiary.educationalAttainments!,
        beneficiary.previousTrainingCourses!,
        beneficiary.foreignLanguages!,
        beneficiary.computerDriving!,
        beneficiary.computerSkills!,
        beneficiary.professionalSkills!,
        beneficiary.sectorPreferences!,
        beneficiary.employment!,
        beneficiary.supportRequiredTrainingLearning!,
        beneficiary.supportRequiredEntrepreneurship!,
        beneficiary.careerGuidanceCounselling!,
        beneficiary.generalNotes!,
      );
      final beneficiaries = await _beneficiaryService.fetchBeneficiaries();
      emit(BeneficiaryLoaded(beneficiaries));
    } catch (e) {
      print('Error updating beneficiary: $e');
      emit(BeneficiaryError(e.toString()));
    }
  }


  Future<void> deleteBeneficiary(int id) async {
    try {
      emit(BeneficiaryLoading());
      await _beneficiaryService.deleteBeneficiary(id);
      fetchBeneficiaries();
    } catch (e) {
      emit(BeneficiaryError(e.toString()));
    }
  }

  Future<void> fetchBeneficiaryDetails(int id) async {
    try {
      emit(BeneficiaryLoading());
      final beneficiary = await _beneficiaryService.fetchBeneficiaryById(id);
      emit(BeneficiaryDetailsLoaded(beneficiary));
    } catch (e) {
      emit(BeneficiaryError(e.toString()));
    }
  }


  Future<void> addBeneficiary(DataBeneficiary beneficiary) async {
    try {
      emit(BeneficiaryLoading());
      await _beneficiaryService.addBeneficiary(
        beneficiary.serialNumber!,
        beneficiary.date!,
        beneficiary.province!,
        beneficiary.name!,
        beneficiary.fatherName!,
        beneficiary.motherName!,
        beneficiary.gender!,
        beneficiary.dateOfBirth!,
        beneficiary.nots!,
        beneficiary.maritalStatus!,
        beneficiary.thereIsDisbility!,
        beneficiary.needAttendant!,
        beneficiary.numberFamilyMember!,
        beneficiary.thereIsDisbilityFamilyMember!,
        beneficiary.losingBreadwinner!,
        beneficiary.governorate!,
        beneficiary.address!,
        beneficiary.email!,
        beneficiary.numberLine!,
        beneficiary.numberPhone!,
        beneficiary.numberId!,
        beneficiary.educationalAttainments!,
        beneficiary.previousTrainingCourses!,
        beneficiary.foreignLanguages!,
        beneficiary.computerDriving!,
        beneficiary.computerSkills!,
        beneficiary.professionalSkills!,
        beneficiary.sectorPreferences!,
        beneficiary.employment!,
        beneficiary.supportRequiredTrainingLearning!,
        beneficiary.supportRequiredEntrepreneurship!,
        beneficiary.careerGuidanceCounselling!,
        beneficiary.generalNotes!,
      );
      final beneficiaries = await _beneficiaryService.fetchBeneficiaries();
      emit(BeneficiaryLoaded(beneficiaries));
    } catch (e) {
      print('Error adding beneficiary: $e');
      emit(BeneficiaryError(e.toString()));
    }
  }

  Future<void> searchBeneficiaries(String query) async {
    try {
      emit(BeneficiaryLoading());
      final beneficiaries = await _beneficiaryService.searchBeneficiaries(query);
      emit(BeneficiaryLoaded(beneficiaries));
    } catch (e) {
      emit(BeneficiaryError(e.toString()));
    }
  }
}
