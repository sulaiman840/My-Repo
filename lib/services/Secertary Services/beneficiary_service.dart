import 'package:dio/dio.dart';
import '../../core/utils/shared_preferences_helper.dart';
import '../../models/Secertary Model/beneficiary_model.dart';

class BeneficiaryService {
  final Dio _dio = Dio();

  Future<void> updateBeneficiary(int id,
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
      List<Disability> thereIsDisbility,
      String needAttendant,
      int numberFamilyMember,
      List<Disability> thereIsDisbilityFamilyMember,
      String losingBreadwinner,
      String governorate,
      String address,
      String email,
      String numberLine,
      String numberPhone,
      String numberId,
      List<EducationalAttainment> educationalAttainments,
      List<PreviousTrainingCourse> previousTrainingCourses,
      List<ForeignLanguage> foreignLanguages,
      String computerDriving,
      String computerSkills,
      List<ProfessionalSkill> professionalSkills,
      String sectorPreferences,
      String employment,
      String supportRequiredTrainingLearning,
      String supportRequiredEntrepreneurship,
      String careerGuidanceCounselling,
      String generalNotes) async {
    try {
      final token = await SharedPreferencesHelper.getJwtToken();
      final data = {
        'serialNumber': serialNumber,
        'date': date,
        'province': province,
        'name': name,
        'fatherName': fatherName,
        'motherName': motherName,
        'gender': gender,
        'dateOfBirth': dateOfBirth,
        'nots': notes,
        'maritalStatus': maritalStatus,
        'thereIsDisbility': thereIsDisbility.map((e) => e.toJson()).toList(),
        'needAttendant': needAttendant,
        'NumberFamilyMember': numberFamilyMember,
        'thereIsDisbilityFamilyMember': thereIsDisbilityFamilyMember.map((e) =>
            e.toJson()).toList(),
        'losingBreadwinner': losingBreadwinner,
        'governorate': governorate,
        'address': address,
        'email': email,
        'numberline': numberLine,
        'numberPhone': numberPhone,
        'numberId': numberId,
        'educationalAttainment': educationalAttainments.map((e) => e.toJson())
            .toList(),
        'previousTrainingCourses': previousTrainingCourses.map((e) =>
            e.toJson()).toList(),
        'foreignLanguages': foreignLanguages.map((e) => e.toJson()).toList(),
        'computerDriving': computerDriving,
        'computerSkills': computerSkills,
        'professionalSkills': professionalSkills.map((e) => e.toJson())
            .toList(),
        'sectorPreferences': sectorPreferences,
        'employment': employment,
        'supportRequiredTrainingLearning': supportRequiredTrainingLearning,
        'supportRequiredEntrepreneurship': supportRequiredEntrepreneurship,
        'careerGuidanceCounselling': careerGuidanceCounselling,
        'generalNotes': generalNotes,
      };

      print('Updating beneficiary with data: $data');
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/updatebeneficiary/$id',
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Beneficiary updated successfully.');
      } else {
        print('Error response status code: ${response.statusCode}');
        print('Error response data: ${response.data}');
        throw Exception('Failed to update beneficiary');
      }
    } on DioError catch (e) {
      print('Failed to update beneficiary: ${e}');
      if (e.response != null) {
        print('Error response status code: ${e.response?.statusCode}');
        print('Error response data: ${e.response?.data}');
        throw Exception(
            'Failed to update beneficiary: ${e.response?.statusMessage}');
      } else {
        print(e);
        throw Exception('Failed to update beneficiary: ${e.message}');
      }
    }
  }

  Future<List<DataBeneficiary>> fetchBeneficiaries() async {
    try {
      final token = await SharedPreferencesHelper.getJwtToken();

      print('Fetching beneficiaries...');
      final response = await _dio.get(
        'http://127.0.0.1:8000/api/getallbeneficiary',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Fetch successful, raw data: ${response.data}');
        List<DataBeneficiary> beneficiaries = Beneficiary
            .fromJson(response.data)
            .dataBeneficiary!;
        print('Fetched beneficiaries: ${beneficiaries.length}');
        beneficiaries.forEach((b) => print(b.toJson()));
        return beneficiaries;
      } else {
        throw Exception('Failed to load beneficiaries');
      }
    } catch (error) {
      print('Failed to load beneficiaries: $error');
      throw Exception('Failed to load beneficiaries: $error');
    }
  }

  Future<void> deleteBeneficiary(int id) async {
    try {
      final token = await SharedPreferencesHelper.getJwtToken();

      print('Deleting beneficiary with id: $id...');
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/deletebeneficiary/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode != 200 &&
          response.data['message'] != 'Beneficiary deleted successfully.') {
        throw Exception('Failed to delete beneficiary');
      }
    } on DioError catch (e) {
      print('Failed to delete beneficiary: ${e.response?.data}');
      throw Exception(
          'Failed to delete beneficiary: ${e.response?.statusMessage}');
    }
  }


  Future<DataBeneficiary> fetchBeneficiaryById(int id) async {
    try {
      final token = await SharedPreferencesHelper.getJwtToken();

      print('Fetching beneficiary details for ID: $id...');
      final response = await _dio.get(
        'http://127.0.0.1:8000/api/getbeneficiary/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Fetch successful, raw data: ${response.data}');
        return DataBeneficiary.fromJson(response.data['dataBeneficiary'][0]);
      } else {
        throw Exception('Failed to load beneficiary details');
      }
    } catch (error) {
      print('Failed to load beneficiary details: $error');
      throw Exception('Failed to load beneficiary details: $error');
    }
  }

  Future<void> addBeneficiary(int serialNumber,
      String date,
      String province,
      String name,
      String fatherName,
      String motherName,
      String gender,
      String dateOfBirth,
      String? notes,
      String maritalStatus,
      List<Disability> thereIsDisbility,
      String needAttendant,
      int numberFamilyMember,
      List<Disability> thereIsDisbilityFamilyMember,
      String losingBreadwinner,
      String governorate,
      String address,
      String email,
      String numberLine,
      String numberPhone,
      String numberId,
      List<EducationalAttainment> educationalAttainments,
      List<PreviousTrainingCourse> previousTrainingCourses,
      List<ForeignLanguage> foreignLanguages,
      String computerDriving,
      String computerSkills,
      List<ProfessionalSkill> professionalSkills,
      String sectorPreferences,
      String employment,
      String supportRequiredTrainingLearning,
      String supportRequiredEntrepreneurship,
      String careerGuidanceCounselling,
      String generalNotes) async {
    try {
      final token = await SharedPreferencesHelper.getJwtToken();
      final data = {
        'serialNumber': serialNumber,
        'date': date,
        'province': province,
        'name': name,
        'fatherName': fatherName,
        'motherName': motherName,
        'gender': gender,
        'dateOfBirth': dateOfBirth,
        'nots': notes,
        'maritalStatus': maritalStatus,
        'thereIsDisbility': thereIsDisbility.map((e) => e.toJson()).toList(),
        'needAttendant': needAttendant,
        'NumberFamilyMember': numberFamilyMember,
        'thereIsDisbilityFamilyMember': thereIsDisbilityFamilyMember.map((e) =>
            e.toJson()).toList(),
        'losingBreadwinner': losingBreadwinner,
        'governorate': governorate,
        'address': address,
        'email': email,
        'numberline': numberLine,
        'numberPhone': numberPhone,
        'numberId': numberId,
        'educationalAttainment': educationalAttainments.map((e) => e.toJson())
            .toList(),
        'previousTrainingCourses': previousTrainingCourses.map((e) =>
            e.toJson()).toList(),
        'foreignLanguages': foreignLanguages.map((e) => e.toJson()).toList(),
        'computerDriving': computerDriving,
        'computerSkills': computerSkills,
        'professionalSkills': professionalSkills.map((e) => e.toJson())
            .toList(),
        'sectorPreferences': sectorPreferences,
        'employment': employment,
        'supportRequiredTrainingLearning': supportRequiredTrainingLearning,
        'supportRequiredEntrepreneurship': supportRequiredEntrepreneurship,
        'careerGuidanceCounselling': careerGuidanceCounselling,
        'generalNotes': generalNotes,
      };

      print('Adding beneficiary with data: $data');
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/addbeneficiary',
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Beneficiary added successfully.');
      } else {
        print('Error response status code: ${response.statusCode}');
        print('Error response data: ${response.data}');
        throw Exception('Failed to add beneficiary');
      }
    } on DioError catch (e) {
      print('Failed to add beneficiary: ${e}');
      if (e.response != null) {
        print('Error response status code: ${e.response?.statusCode}');
        print('Error response data: ${e.response?.data}');
        throw Exception(
            'Failed to add beneficiary: ${e.response?.statusMessage}');
      } else {
        throw Exception('Failed to add beneficiary: ${e.message}');
      }
    }
  }

  Future<List<DataBeneficiary>> searchBeneficiaries(String query) async {
    try {
      final token = await SharedPreferencesHelper.getJwtToken();

      final response = await _dio.get(
        'http://127.0.0.1:8000/api/searchbeneficiary/$query',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data as List<dynamic>;
        return responseData.map((item) => DataBeneficiary.fromJson(item)).toList();
      } else {
        throw Exception('Failed to search beneficiaries: ${response.statusCode}');
      }
    } catch (error) {
      if (error is DioError && error.response?.statusCode == 404) {
        throw ('No results found.');
      } else {
        throw Exception('Failed to search beneficiaries: $error');
      }
    }
  }
}