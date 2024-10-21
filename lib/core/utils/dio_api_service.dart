import 'package:dio/dio.dart';

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

  Future<Map<String, dynamic>> put({
    required String endPoint,
    required Map<String, dynamic>? data,
    String? token,
  }) async {
    _dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    var response = await _dio.put(
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
    );

    return response.data;
  }

  Future<dynamic> postWithImage({
    required String endPoint,
    required FormData? data,
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
}
