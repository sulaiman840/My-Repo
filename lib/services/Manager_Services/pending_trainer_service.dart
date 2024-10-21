import 'package:dio/dio.dart';

import '../../core/utils/shared_preferences_helper.dart';
import '../../models/Pending Model/pending_trainer.dart';
import '../../models/notification_data.dart';
import '../dio_error.dart';
import '../notification_service.dart';
import '../token_service.dart';

class PendingTrainerService {
  final Dio _dio = Dio();
  final TokenService _tokenService = TokenService();
  final NotificationService _notificationService = NotificationService();

  Future<List<PendingTrainer>> fetchPendingTrainers() async {
    try {
      final token = await SharedPreferencesHelper.getJwtToken();

      final response = await _dio.get(
        'http://127.0.0.1:8000/api/showallrequesttrainer',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<PendingTrainer> pendingTrainers = (response.data['dataRequest'] as List)
            .map((pendingTrainerJson) => PendingTrainer.fromJson(pendingTrainerJson))
            .toList();
        return pendingTrainers;
      } else {
        throw Exception('Failed to load pending trainers');
      }
    } catch (error) {
      throw Exception('Failed to load pending trainers: $error');
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
          // print('Secretary Device is not  turned on yet');
          print('hhhhhhhh');
        }
        if (SecretaryFcmToken != null) {
          // Store the notification
          NotificationData notification = NotificationData(
            fcmToken: SecretaryFcmToken,
            title: 'Manager Approve a Trainer',
            body: 'a new Trainer has been accepted in our center',
          );

          await _tokenService.storeNotification(notification);}

        print('Trainer approved successfully.');
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

}
