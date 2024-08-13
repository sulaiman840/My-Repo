
import 'package:bloc/bloc.dart';

import '../../../services/Secertary Services/beneficiary_course_service.dart';
import 'beneficiary_course_state.dart';

class BeneficiaryCourseCubit extends Cubit<BeneficiaryCourseState> {
  final BeneficiaryCourseService _beneficiaryCourseService;

  BeneficiaryCourseCubit(this._beneficiaryCourseService)
      : super(BeneficiaryCourseInitial());

  Future<void> addBeneficiaryToCourse(int beneficiaryId, int courseId) async {
    try {
      emit(BeneficiaryCourseLoading());
      await _beneficiaryCourseService.addBeneficiaryToCourse(
          beneficiaryId, courseId);
      emit(BeneficiaryCourseAdded());
      fetchBeneficiaryCourses(beneficiaryId); // Refresh list after adding
    } catch (e) {
      emit(BeneficiaryCourseError(e.toString()));
    }
  }

  Future<void> fetchBeneficiaryCourses(int beneficiaryId) async {
    try {
      emit(BeneficiaryCourseLoading());
      final courses = await _beneficiaryCourseService.fetchBeneficiaryCourses(
          beneficiaryId);
      emit(BeneficiaryCourseLoaded(courses));
    } catch (e) {
      emit(BeneficiaryCourseError(e.toString()));
    }
  }

  Future<void> deleteBeneficiaryFromCourse(int beneficiaryId,
      int courseId) async {
    try {
      emit(BeneficiaryCourseLoading());
      await _beneficiaryCourseService.deleteBeneficiaryFromCourse(
          beneficiaryId, courseId);
      emit(BeneficiaryCourseDeleted());
      fetchBeneficiaryCourses(beneficiaryId);
    } catch (e) {
      emit(BeneficiaryCourseError(e.toString()));
    }
  }

  void fetchBeneficiariesByCourse(int courseId) async {
    try {
      emit(BeneficiaryCourseLoading());
      final beneficiaries = await _beneficiaryCourseService
          .fetchBeneficiariesByCourse(courseId);
      emit(BeneficiaryByCourseLoaded(beneficiaries));
    } catch (e) {
      emit(BeneficiaryCourseError(e.toString()));
    }
  }

  Future<void> checkInBeneficiary(int beneficiaryId, int courseId) async {
    try {
      emit(BeneficiaryCourseLoading());
      final message = await _beneficiaryCourseService.checkInBeneficiary(
          beneficiaryId, courseId);
      emit(BeneficiaryCheckedIn(message));
    } catch (e) {
      emit(BeneficiaryCourseError(e.toString()));
    }
  }
}
