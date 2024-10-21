

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:file_saver/file_saver.dart';
import 'package:universal_html/html.dart' as html; // Import the dart:html library
import '../../core/errors/failures.dart';
import '../../core/utils/shared_preferences_helper.dart';
import '../../models/Secertary Model/beneficiary_model.dart';
import 'dart:typed_data';

import '../../models/notification_data.dart';
import '../notification_service.dart';
import '../token_service.dart';

class BeneficiaryService {
  final Dio _dio = Dio();
  final TokenService _tokenService = TokenService();
  final NotificationService _notificationService = NotificationService();

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
        'educational': educationalAttainments.map((e) => e.toJson())
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
        'educational': educationalAttainments.map((e) => e.toJson())
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
        String accessToken = await _tokenService.fetchAccessToken();
      String? managerFcmToken = await _tokenService.fetchFcmTokenByRole('manager');
    //  String? SecetaryFcmToken = await _tokenService.fetchFcmTokenByRole('secretary');
      final bool? manager_falge = await SharedPreferencesHelper.getCheckFlag();

      print(managerFcmToken);
 //     print(SecetaryFcmToken);
      print(manager_falge);

      if (managerFcmToken != null && manager_falge==true) {
        // Send the notification
        await _notificationService.sendNotification(accessToken, managerFcmToken);
        print('Notification has been sent to Manager FCM token successfully');

      } else {
        print('Manager Device is not turned on yet');
      }
      if (managerFcmToken != null) {
        // Store the notification
        NotificationData notification = NotificationData(
          fcmToken: managerFcmToken,
          title: 'Beneficiary Request ',
          body: 'Secertary Added a new Beneficiary request',
        );

        await _tokenService.storeNotification(notification);}


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





  Future<Either<Failure, dynamic>> exportBeneficiariesToExcel(Map<String, dynamic> filters) async {
    try {
      final token = await SharedPreferencesHelper.getJwtToken();

      final response = await _dio.post(
        'http://127.0.0.1:8000/api/beneficiaryexportexcel',

        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          responseType: ResponseType.bytes, // Ensures that response is treated as bytes
        ),
      );

      if (response.statusCode == 200) {
        final contentDisposition = response.headers['content-disposition']?.first;
        final filename = contentDisposition?.split('filename=')[1] ?? 'beneficiaries_export.xlsx';
        final bytes = response.data as Uint8List;

        await FileSaver.instance.saveFile(
          name: filename,
          bytes: bytes,
          ext: "xlsx",
          mimeType: MimeType.microsoftExcel,
        );

        return right("Export successful");
      } else {
        throw Exception('Failed to export beneficiaries with status: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print("DioError: $e");
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      print("Error: $e");
      return left(ServerFailure(e.toString()));
    }
  }
  Future<void> importBeneficiariesFromExcel(List<int> excelFile) async {
    try {
      final token = await SharedPreferencesHelper.getJwtToken();

      FormData formData = FormData.fromMap({
        "excel_file": MultipartFile.fromBytes(
          excelFile,
          filename: 'beneficiaries.xlsx',
        ),
      });

      final response = await _dio.post(
        'http://127.0.0.1:8000/api/beneficiaryimportexcel',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Import failed with status: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to import beneficiaries: $error');
    }
  }
}

