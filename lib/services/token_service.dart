import 'package:dio/dio.dart';

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

      if (response.statusCode == 200) {
        print("ssssssssssssssss");
        print(response.data['Fcm_token']['fcm_token']);

        return response.data['Fcm_token']['fcm_token'];
        // Ensure this matches the structure of your JSON response
      } else {
        throw Exception('Failed to fetch FCM token for role: $role');
      }
    } catch (error) {
      throw Exception('Failed to fetch FCM token for role: $error');
    }
  }

}
