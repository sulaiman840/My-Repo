import 'package:dio/dio.dart';

import '../../core/utils/shared_preferences_helper.dart';
import '../../models/Pending Model/pending_course_model.dart';
import '../../models/notification_data.dart';
import '../dio_error.dart';
import '../notification_service.dart';
import '../token_service.dart';

class PendingRequestService {
  final Dio _dio = Dio();
  final TokenService _tokenService = TokenService();
  final NotificationService _notificationService = NotificationService();


  Future<List<PendingRequest>> fetchPendingRequests() async {
    try {
      final token = await SharedPreferencesHelper.getJwtToken();
      final response = await _dio.get(
        'http://127.0.0.1:8000/api/showallrequestCourses',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<PendingRequest> pendingRequests = (response.data['dataRequest'] as List)
            .map((requestJson) => PendingRequest.fromJson(requestJson))
            .toList();
        return pendingRequests;
      } else {
        throw Exception('Failed to load pending requests');
      }
    } on DioError catch (e) {
      print(" error: $e");
      throw Exception(DioErrorHandler.handleError(e));
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
        // print('Secretary Device is not  turned on yet');
        print('hhhhhhhh');
      }
      if (SecretaryFcmToken != null) {
        // Store the notification
        NotificationData notification = NotificationData(
          fcmToken: SecretaryFcmToken,
          title: 'Manager Approve a Course',
          body: 'a Course has been available in our center',
        );

        await _tokenService.storeNotification(notification);}

      print('Course approved successfully.');

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
}
