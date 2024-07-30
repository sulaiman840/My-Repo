import 'package:dio/dio.dart';
import '../models/Auth Model/user_model.dart';
import '../../services/dio_error.dart';
import '../core/utils/shared_preferences_helper.dart';

class StaffLoginService {
  final Dio _dio = Dio();

  Future<UserModel> login({required String email, required String password, required String fcmToken}) async {
    try {
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/loginstaff',

        data: {
          'email': email,
          'password': password,
          'fcm_token': fcmToken,
        },
      );

      print("LoginService response: ${response.data}");

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        final data = response.data['user'];
        data['_token'] = response.data['_token'];
        print("LoginService parsed data: $data");
        return UserModel.fromJson(data);
      } else {
        print("LoginService error: ${response.statusCode} - ${response.statusMessage}");
        throw Exception('Login failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print("LoginService error: $e");
      throw Exception(DioErrorHandler.handleError(e));
    }
  }
  Future<void> logout() async {
    try {
      final token = await SharedPreferencesHelper.getJwtToken();
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/logout',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        print("Logout successful");
      } else {
        print("Logout error: ${response.statusCode} - ${response.statusMessage}");
        throw Exception('Logout failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print("LogoutService error: $e");
      throw Exception(DioErrorHandler.handleError(e));
    }
  }

}
