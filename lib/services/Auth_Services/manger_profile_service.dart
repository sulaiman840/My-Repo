import 'package:dio/dio.dart';
import 'package:project2/models/Auth%20Model/user_profile.dart';
import '../../core/utils/shared_preferences_helper.dart';

class MangerProfileService {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://127.0.0.1:8000/api/userProfile';

  Future<UserProfile> fetchUserProfile() async {
    try {
      final token = await SharedPreferencesHelper.getJwtToken();
      final response = await _dio.get(
        '$_baseUrl',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Response data: ${response.data}');
        return UserProfile.fromJson(response.data[0]);
      } else {
        print('Failed to load user profile: ${response.statusMessage}');
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      if (e is DioError) {
        print('DioError: ${e.response?.data}');
        print('DioError Type: ${e.type}');
        print('DioError Message: ${e.message}');
      } else {
        print('Error: $e');
      }
      throw Exception('Failed to load user profile');
    }
  }
}
