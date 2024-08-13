
import 'package:dio/dio.dart';

import '../../models/Secertary Model/beneficiary_course_model.dart';
import '../../models/Secertary Model/course_benficary_view_model.dart';


class BeneficiaryCourseService {
  final Dio _dio = Dio();

  Future<void> addBeneficiaryToCourse(int beneficiaryId, int courseId) async {
    try {
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/beneficiarywithcourse',
        data: {
          'beneficiary_id': beneficiaryId.toString(),
          'course_id': courseId.toString(),
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add beneficiary to course');
      }
    } catch (error) {
      throw Exception('Failed to add beneficiary to course: $error');
    }
  }

  Future<List<BeneficiaryCourse>> fetchBeneficiaryCourses(int beneficiaryId) async {
    try {
      final response = await _dio.get(
        'http://127.0.0.1:8000/api/showbeneficiarywithcourse/$beneficiaryId',
      );

      if (response.statusCode == 200) {
        List<BeneficiaryCourse> courses = (response.data['message'] as List)
            .map((courseJson) => BeneficiaryCourse.fromJson(courseJson))
            .toList();
        return courses;
      } else {
        throw Exception('Failed to load beneficiary courses');
      }
    } catch (error) {
      throw Exception('Failed to load beneficiary courses: $error');
    }
  }

  Future<void> deleteBeneficiaryFromCourse(int beneficiaryId, int courseId) async {
    try {
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/deletebeneficiarywithcourse',
        data: {
          'beneficiary_id': beneficiaryId.toString(),
          'course_id': courseId.toString(),
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete beneficiary from course');
      }
    } catch (error) {
      throw Exception('Failed to delete beneficiary from course: $error');
    }
  }
  Future<List<BeneficiaryByCourse>> fetchBeneficiariesByCourse(int courseId) async {
    try {
      final response = await _dio.get(
        'http://127.0.0.1:8000/api/showbeneficiaryrecordcourse/$courseId',
        options: Options(
          headers: {'Authorization': 'Bearer your_token_here'},
        ),
      );

      if (response.statusCode == 200) {
        List<BeneficiaryByCourse> beneficiaries = (response.data['message'] as List)
            .map((json) => BeneficiaryByCourse.fromJson(json))
            .toList();
        return beneficiaries;
      } else {
        throw Exception('Failed to load beneficiaries');
      }
    } catch (error) {
      print(error);
      throw Exception('Failed to load beneficiaries: $error');
    }
  }

  Future<String> checkInBeneficiary(int beneficiaryId, int courseId) async {
    try {
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/trackingbeneficiary',
        data: {
          'beneficiary_id': beneficiaryId.toString(),
          'course_id': courseId.toString(),
        },
      );

      if (response.statusCode == 200) {
        return response.data['message'];
      } else {
        throw Exception('Failed to check in beneficiary');
      }
    } catch (error) {
      throw Exception('Failed to check in beneficiary: $error');
    }
  }
}
