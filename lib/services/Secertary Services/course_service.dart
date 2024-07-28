import 'package:dio/dio.dart';
import '../../models/Secertary Model/course_model.dart';

class CourseService {
  final Dio _dio = Dio();

  Future<List<Course>> fetchCourses() async {
    try {
      final response = await _dio.get(
        'http://127.0.0.1:8000/api/showallcourses',
        options: Options(
          headers: {
            'Authorization': 'Bearer your_token_here',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<Course> courses = (response.data['data'] as List)
            .map((courseJson) => Course.fromJson(courseJson))
            .toList();
        return courses;
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (error) {
      throw Exception('Failed to load courses: $error');
    }
  }

  Future<void> deleteCourse(int id) async {
    try {
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/destroycourse/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer your_token_here',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete course');
      }
    } catch (error) {
      throw Exception('Failed to delete course: $error');
    }
  }

  Future<void> updateCourse(int id, Course course) async {
    try {
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/updatecourse/$id',
        data: course.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer your_token_here',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update course');
      }
    } catch (error) {
      throw Exception('Failed to update course: $error');
    }
  }

  Future<void> addCourse(Course course) async {
    try {
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/addcourse',
        data: {
          'nameCourse': course.nameCourse,
          'coursePeriod': course.coursePeriod,
          'type': course.type,
          'courseStatus': course.courseStatus,
          'specialty': course.specialty,
          'description': course.description,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer your_token_here',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add course');
      }
    } catch (error) {
      throw Exception('Failed to add course: $error');
    }
  }
  Future<Course> fetchCourseDetail(int id) async {
    try {
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/showcourse/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer your_token_here',
          },
        ),
      );

      if (response.statusCode == 200) {
        return Course.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load course detail');
      }
    } catch (error) {
      throw Exception('Failed to load course detail: $error');
    }
  }
}
