import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

import '../../constants.dart';

class DioApiService
{
  final _baseUrl = "http://127.0.0.1:8000/api/";
  final Dio _dio;

  DioApiService(this._dio);

  Future<dynamic> get({
  required String endPoint,
  String? token,
}) async {
    _dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    var response = await _dio.get(
        '$_baseUrl$endPoint',
    );

    return response.data;
}

  Future<Map<String, dynamic>> post({
    required String endPoint,
    required Map<String, dynamic>? data,
    String? token,
  }) async {
    _dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    var response = await _dio.post(
      '$_baseUrl$endPoint',
      data: data,
    );

    return response.data;
  }

  Future<dynamic> delete({
    required String endPoint,
    required Map<String, dynamic>? data,
    String? token,
  }) async {
    _dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    var response = await _dio.delete(
      '$_baseUrl$endPoint',
      data: data,
    );

    return response.data;
  }

  /*Future<Map<String, dynamic>> postWithImage({
    required String endPoint,
    required Map<String, dynamic>? data,
    String? token,
    File? imageFile,
  }) async {
    _dio.options.headers = {
      'Authorization': 'Bearer $token',
    };

    var formData = FormData();

    // Add data to formData
    if (data != null) {
      data.forEach((key, value) {
        formData.fields.add(MapEntry(key, value.toString()));
      });
    }

    // Add imageFile to formData
    if (imageFile != null) {
      String fileName = imageFile.path.split('/').last;
      formData.files.add(
        MapEntry(
          'image',
          await MultipartFile.fromFile(imageFile.path, filename: fileName),
        ),
      );
    }

    var response = await _dio.post(
      '$_baseUrl$endPoint',
      data: formData,
    );

    return response.data;
  }*/
  /*Future<dynamic> postWithImage({
    required String endPoint,
    required Map<String, String> data,
    required String? imagePath,
    required String? token,
  }) async {
    try {
      var formData = FormData.fromMap(data);

      if (imagePath != null) {
        formData.files.add(MapEntry(
          'img',
          await MultipartFile.fromFile(imagePath, filename: 'upload.jpg'),
        ));
      }

      Options options = Options(
        headers: {
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      var response = await Dio().post(
        '$_baseUrl$endPoint',
        data: formData,
        options: options,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        print('Dio POSTIMAGE Data: $data');
        return data;
      } else {
        throw Exception(
          'there is an error with status code ${response.statusCode} and with body : ${response.data}',
        );
      }
    } on DioException catch (e) {
      throw Exception(
        'Failed to post with image: ${e.message}',
      );
    }
  }*/
  /*Future<dynamic> postWithImage({
    required String endPoint,
    String? token,
    required FormData data,
  }) async {
    _dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    };
    final response = await _dio.post(
      '$_baseUrl$endPoint',
      data: data,
    );
    return response.data;
  }*/
}
