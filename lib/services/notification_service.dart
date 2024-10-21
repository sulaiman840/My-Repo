import 'package:dio/dio.dart';

import '../models/notification_message_model.dart';

class NotificationService {
  final Dio _dio = Dio();

  Future<void> sendNotification(String accessToken, String fcmToken) async {
    try {

      final response = await _dio.post(
        'https://fcm.googleapis.com/v1/projects/warehouse-management-d8a87/messages:send',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          "message": {
            "token": fcmToken,
            "notification": {
              "title": "Course Added",
              "body": "A new course has been added successfully."
            }
          }
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to send notificationnnnnnnnnn');
      }
    } catch (error) {
      throw Exception('Failed to send notification: $error');
    }
  }
  Future<List<NotificationItem>> fetchNotificationsById(int userId) async {
    try {
      final response = await _dio.get(
        'http://127.0.0.1:8000/api/shownotification/$userId',
      );

      if (response.statusCode == 200) {
        NotificationResponse notificationResponse =
        NotificationResponse.fromJson(response.data);
        return notificationResponse.notifications;
      } else {
        throw Exception('Failed to fetch notifications');
      }
    } catch (error) {
      throw Exception('Failed to fetch notifications: $error');
    }
  }
}
