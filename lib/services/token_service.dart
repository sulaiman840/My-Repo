import 'package:dio/dio.dart';

import '../models/notification_data.dart';

class TokenService {
  final Dio _dio = Dio();

  Future<String> fetchAccessToken() async {
    try {
      final response = await _dio.get(
        'http://127.0.0.1:8000/api/firebase/access-token',
      );

      if (response.statusCode == 200) {
        return response.data['access_token'];
      } else {
        throw Exception('Failed to fetch access token');
      }
    } catch (error) {
      print("HH");
      throw Exception('Failed to fetch access token: $error');
    }
  }

  Future<String?> fetchFcmTokenByRole(String role) async {
    try {
      final response = await _dio.get(
        'http://127.0.0.1:8000/api/getfcmtoken/$role',
      );
      print("DDDDDDDDDDDD");
      print(response);
      print("DDDDDDDDDDDD");

      if (response.statusCode == 200) {
        print("ssssssssssssssss");
        print(response.data['Fcm_token']['fcm_token']);
        print("ssssssssssssssss");

        return response.data['Fcm_token']['fcm_token'];
      } else {
        throw Exception('Failed to fetch FCM token for role: $role');
      }
    } catch (error) {
      throw Exception('Failed to fetch FCM token for role: $error');
    }
  }

  Future<void> storeNotification(NotificationData notification) async {
    try {
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/storenotification',
        data: notification.toJson(),
      );

      if (response.statusCode == 200) {
        print('Notification stored successfully');
      } else {
        throw Exception('Failed to store notification');
      }
    } catch (error) {
      throw Exception('Failed to store notification: $error');
    }
  }
}
