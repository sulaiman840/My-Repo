import 'package:dio/dio.dart';

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
        throw Exception('Failed to send notification');
      }
    } catch (error) {
      throw Exception('Failed to send notification: $error');
    }
  }
}
