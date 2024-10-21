import 'package:dio/dio.dart';
import '../../core/utils/shared_preferences_helper.dart';
import '../../models/Pending Model/pending_beneficiary_request_model.dart';
import '../../models/notification_data.dart';
import '../dio_error.dart';
import '../notification_service.dart';
import '../token_service.dart';

class PendingBeneficiaryService {
  final Dio _dio = Dio();
  final TokenService _tokenService = TokenService();
  final NotificationService _notificationService = NotificationService();
  static const int maxRetries = 3;
  static const int initialDelay = 1000;

  Future<List<DataRequest>> fetchPendingRequests() async {
    final token = await SharedPreferencesHelper.getJwtToken();
    int retries = 0;
    int delay = initialDelay;

    while (true) {
      try {
        final response = await _dio.get(
          'http://127.0.0.1:8000/api/showallrequestbeneficiary',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );

        if (response.statusCode == 200) {
          List<DataRequest> pendingRequests = (response.data['dataRequest'] as List)
              .map((requestJson) => DataRequest.fromJson(requestJson))
              .toList();
          return pendingRequests;
        } else {
          throw Exception('Failed to load pending requests');
        }
      } catch (e) {
        if (e is DioError && e.response?.statusCode == 429) {
          retries++;  print(e);
          if (retries > maxRetries) {
            throw Exception('Too many requests. Please try again later.');

          }
          await Future.delayed(Duration(milliseconds: delay));
          delay *= 2;
        } else {
          print(e);
          throw Exception(DioErrorHandler.handleError(e));
        }
      }
    }
  }

  Future<void> approveRequest(int id) async {
    final token = await SharedPreferencesHelper.getJwtToken();
    try {
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/approverequest/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      // if (response.statusCode != 200) {
      //   throw Exception('Failed to approve request');
      // }
      if (response.statusCode == 200) {

        String accessToken = await _tokenService.fetchAccessToken();
        String? SecretaryFcmToken = await _tokenService.fetchFcmTokenByRole('secretary');
        final bool? manager_falge = await SharedPreferencesHelper.getCheckFlag();
        print(SecretaryFcmToken);

        print(manager_falge);

        if (SecretaryFcmToken != null && manager_falge==false) {
          // Send the notification
          await _notificationService.sendNotification(accessToken, SecretaryFcmToken);
          print('Notification has been sent to Secretary FCM token successfully');

        } else {
      //    print('Secretary Device is not  turned on yet');
          print('hhhhhhhh');
        }
        if (SecretaryFcmToken != null) {
          // Store the notification
          NotificationData notification = NotificationData(
            fcmToken: SecretaryFcmToken,
            title: 'Manager Approve a Beneficiary',
            body: 'a new Beneficiary has been accepted in our center',
          );

          await _tokenService.storeNotification(notification);}

        print('Beneficiary approved successfully.');


      }
    } catch (e) {
      throw Exception(DioErrorHandler.handleError(e));
    }
  }

  Future<void> rejectRequest(int id) async {
    final token = await SharedPreferencesHelper.getJwtToken();
    try {
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/rejectrequest/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to reject request');
      }
    } catch (e) {
      throw Exception(DioErrorHandler.handleError(e));
    }
  }


  Future<void> editBeneficiaryManager(
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
        'thereIsDisbilityFamilyMember': thereIsDisbilityFamilyMember.map((e) => e.toJson()).toList(),
        'losingBreadwinner': losingBreadwinner,
        'governorate': governorate,
        'address': address,
        'email': email,
        'numberline': numberLine,
        'numberPhone': numberPhone,
        'numberId': numberId,
        'educational': educationalAttainments.map((e) => e.toJson()).toList(),
        'previousTrainingCourses': previousTrainingCourses.map((e) => e.toJson()).toList(),
        'foreignLanguages': foreignLanguages.map((e) => e.toJson()).toList(),
        'computerDriving': computerDriving,
        'computerSkills': computerSkills,
        'professionalSkills': professionalSkills.map((e) => e.toJson()).toList(),
        'sectorPreferences': sectorPreferences,
        'employment': employment,
        'supportRequiredTrainingLearning': supportRequiredTrainingLearning,
        'supportRequiredEntrepreneurship': supportRequiredEntrepreneurship,
        'careerGuidanceCounselling': careerGuidanceCounselling,
        'generalNotes': generalNotes,
      };

      print('Updating beneficiary with data: $data');
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/updaterequest/$id',
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
        throw Exception('Failed to update beneficiary: ${e.response?.statusMessage}');
      } else {
        throw Exception('Failed to update beneficiary: ${e.message}');
      }
    }
  }
}