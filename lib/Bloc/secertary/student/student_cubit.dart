// import 'package:bloc/bloc.dart';
// import '../../../models/Secertary Model/student_model.dart';
// import '../../../services/Secertary Services/student_service.dart';
// import 'student_state.dart';
//
// class BeneficiaryCubit extends Cubit<BeneficiaryState> {
//   final BeneficiaryService _studentService;
//
//   BeneficiaryCubit(this._studentService) : super(BeneficiaryInitial());
//
//   Future<void> fetchBeneficiaries() async {
//     try {
//       emit(BeneficiaryLoading());
//       final beneficiaries = await _studentService.fetchBeneficiaries();
//       emit(BeneficiaryLoaded(beneficiaries));
//     } catch (e) {
//       emit(BeneficiaryError(e.toString()));
//     }
//   }
//
//   Future<void> updateBeneficiary(Beneficiary beneficiary) async {
//     try {
//       emit(BeneficiaryLoading());
//       await _studentService.updateBeneficiary(
//         beneficiary.id,
//         beneficiary.serialNumber,
//         beneficiary.date,
//         beneficiary.province,
//         beneficiary.name,
//         beneficiary.fatherName,
//         beneficiary.motherName,
//         beneficiary.gender,
//         beneficiary.dateOfBirth,
//         beneficiary.notes,
//         beneficiary.maritalStatus,
//         beneficiary.disabilities,
//         beneficiary.needAttendant,
//         beneficiary.numberFamilyMember,
//         beneficiary.disabilities,
//         beneficiary.losingBreadwinner,
//         beneficiary.governorate,
//         beneficiary.address,
//         beneficiary.email,
//         beneficiary.numberLine,
//         beneficiary.numberPhone,
//         beneficiary.numberId,
//         beneficiary.educationalAttainments,
//         beneficiary.previousTrainingCourses,
//         beneficiary.foreignLanguages,
//         beneficiary.computerDriving,
//         beneficiary.computerSkills,
//         beneficiary.professionalSkills,
//         beneficiary.sectorPreferences,
//         beneficiary.employment,
//         beneficiary.supportRequiredTrainingLearning,
//         beneficiary.supportRequiredEntrepreneurship,
//         beneficiary.careerGuidanceCounselling,
//         beneficiary.generalNotes,
//       );
//
//
//       final beneficiaries = await _studentService.fetchBeneficiaries();
//       emit(BeneficiaryLoaded(beneficiaries));
//     } catch (e) {
//       print("$e");
//       emit(BeneficiaryError(e.toString()));
//     }
//   }
//
//   Future<void> deleteBeneficiary(int id) async {
//     try {
//       emit(BeneficiaryLoading());
//       await _studentService.deleteBeneficiary(id);
//       fetchBeneficiaries();
//     } catch (e) {
//       emit(BeneficiaryError(e.toString()));
//     }
//   }
// }
//
