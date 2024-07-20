// import 'package:dio/dio.dart';
// import '../../core/utils/shared_preferences_helper.dart';
// import '../../models/Secertary Model/student_model.dart';
//
// class BeneficiaryService {
//   final Dio _dio = Dio();
//
//   Future<List<Beneficiary>> fetchBeneficiaries() async {
//     try {
//       final response = await _dio.get(
//         'http://127.0.0.1:8000/api/getallbeneficiary',
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer your_token_here',
//           },
//         ),
//       );
//
//       if (response.statusCode == 200) {
//         List<Beneficiary> beneficiaries = (response.data['dataBeneficiary'] as List)
//             .map((beneficiaryJson) => Beneficiary.fromJson(beneficiaryJson))
//             .toList();
//         return beneficiaries;
//       } else {
//         throw Exception('Failed to load beneficiaries');
//       }
//     } catch (error) {
//       throw Exception('Failed to load beneficiaries: $error');
//     }
//   }
//
//   Future<void> updateBeneficiary(
//       int id,
//       int serialNumber,
//       String date,
//       String province,
//       String name,
//       String fatherName,
//       String motherName,
//       String gender,
//       String dateOfBirth,
//       String? notes,
//       String maritalStatus,
//       List<Disability> thereIsDisbility,
//       String needAttendant,
//       int numberFamilyMember,
//       List<Disability> thereIsDisbilityFamilyMember,
//       String losingBreadwinner,
//       String governorate,
//       String address,
//       String email,
//       String numberLine,
//       String numberPhone,
//       String numberId,
//       List<EducationalAttainment> educationalAttainments,
//       List<PreviousTrainingCourse> previousTrainingCourses,
//       List<ForeignLanguage> foreignLanguages,
//       String computerDriving,
//       String computerSkills,
//       List<ProfessionalSkill> professionalSkills,
//       String sectorPreferences,
//       String employment,
//       String supportRequiredTrainingLearning,
//       String supportRequiredEntrepreneurship,
//       String careerGuidanceCounselling,
//       String generalNotes) async {
//     try {
//       final response = await _dio.post(
//         'http://127.0.0.1:8000/api/updatebeneficiary/$id',
//         data: {
//           'serialNumber': serialNumber,
//           'date': date,
//           'province': province,
//           'name': name,
//           'fatherName': fatherName,
//           'motherName': motherName,
//           'gender': gender,
//           'dateOfBirth': dateOfBirth,
//           'nots': notes,
//           'maritalStatus': maritalStatus,
//           'thereIsDisbility': thereIsDisbility.map((e) => e.toJson()).toList(),
//           'needAttendant': needAttendant,
//           'NumberFamilyMember': numberFamilyMember,
//           'thereIsDisbilityFamilyMember': thereIsDisbilityFamilyMember.map((e) => e.toJson()).toList(),
//           'losingBreadwinner': losingBreadwinner,
//           'governorate': governorate,
//           'address': address,
//           'email': email,
//           'numberline': numberLine,
//           'numberPhone': numberPhone,
//           'numberId': numberId,
//           'educationalAttainment': educationalAttainments.map((e) => e.toJson()).toList(),
//           'previousTrainingCourses': previousTrainingCourses.map((e) => e.toJson()).toList(),
//           'foreignLanguages': foreignLanguages.map((e) => e.toJson()).toList(),
//           'computerDriving': computerDriving,
//           'computerSkills': computerSkills,
//           'professionalSkills': professionalSkills.map((e) => e.toJson()).toList(),
//           'sectorPreferences': sectorPreferences,
//           'employment': employment,
//           'supportRequiredTrainingLearning': supportRequiredTrainingLearning,
//           'supportRequiredEntrepreneurship': supportRequiredEntrepreneurship,
//           'careerGuidanceCounselling': careerGuidanceCounselling,
//           'generalNotes': generalNotes,
//         },
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer your_token_here',
//             'Content-Type': 'application/json',
//           },
//         ),
//       );
//
//       if (response.statusCode == 200 && response.data['message'] == 'Beneficiary updated successfully.') {
//         print('Beneficiary updated successfully.');
//       } else {
//         throw Exception('Failed to update beneficiary');
//       }
//     } on DioError catch (e) {
//       print('Failed to update beneficiary: ${e.response?.data}');
//       throw Exception('Failed to update beneficiary: ${e.response?.statusMessage}');
//     }
//   }
//
//
//
//   Future<void> deleteBeneficiary(int id) async {
//     try {
//       final response = await _dio.post(
//         'http://127.0.0.1:8000/api/deletebeneficiary/$id',
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer your_token_here',
//             'Content-Type': 'application/json',
//           },
//         ),
//       );
//
//       if (response.statusCode == 200 && response.data['message'] == 'Beneficiary deleted successfully.') {
//         print('Beneficiary deleted successfully.');
//       } else {
//         throw Exception('Failed to delete beneficiary');
//       }
//     } on DioError catch (e) {
//      print('Failed to delete beneficiary: ${e.response?.data}');
//       throw Exception('Failed to delete beneficiary: ${e.response?.statusMessage}');
//     }
//   }
//
// }
