import 'package:dio/dio.dart';

class EducationService {
  final Dio _dio = Dio();

  Future<String> fetchRateCompletedCourses() async {
    try {
      final response = await _dio.get('http://127.0.0.1:8000/api/ratecompletedcourses');
      if (response.statusCode == 200) {
        return response.data['RateCompletedCourses'];
      } else {
        throw Exception('Failed to load rate of completed courses');
      }
    } catch (error) {
      throw Exception('Failed to load rate of completed courses: $error');
    }
  }

  Future<String> fetchRateCompletedBeneficiary() async {
    try {
      final response = await _dio.get('http://127.0.0.1:8000/api/ratecompletedbeneficiary');
      if (response.statusCode == 200) {
        return response.data['RateCopmleted'];
      } else {
        throw Exception('Failed to load rate of completed beneficiaries');
      }
    } catch (error) {
      throw Exception('Failed to load rate of completed beneficiaries: $error');
    }
  }

  Future<String> fetchRateProcessingBeneficiary() async {
    try {
      final response = await _dio.get('http://127.0.0.1:8000/api/rateproceesingbeneficiary');
      if (response.statusCode == 200) {
        return response.data['RateProceesing'];
      } else {
        throw Exception('Failed to load rate of processing beneficiaries');
      }
    } catch (error) {
      throw Exception('Failed to load rate of processing beneficiaries: $error');
    }
  }

  Future<int> fetchAverageAge() async {
    try {
      final response = await _dio.get('http://127.0.0.1:8000/api/getaverageage');
      if (response.statusCode == 200) {
        return response.data['average_age'];
      } else {
        throw Exception('Failed to load average age');
      }
    } catch (error) {
      throw Exception('Failed to load average age: $error');
    }
  }
}
