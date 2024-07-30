
import 'dart:typed_data';
import 'package:dio/dio.dart';

import '../../../services/dio_error.dart';
import '../../models/Auth Model/register_model.dart';

class RegisterService {
  final Dio _dio = Dio();

  RegisterService();

  Future<User> register({
    required String name,
    required String email,
    required String number,
    required String password,
    required String role,
    required Uint8List imageBytes,
  }) async {
    FormData formData = FormData.fromMap({
      'name': name,
      'email': email,
      'number': number,
      'password': password,
      'role': role,
      'image': MultipartFile.fromBytes(imageBytes, filename: 'upload.jpg'),
    });

    try {
      final response = await _dio.post('http://127.0.0.1:8000/api/register', data: formData);

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return User.fromJson(response.data['user']);
      } else {
        throw Exception('Registration failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(DioErrorHandler.handleError(e));
    }
  }
}
