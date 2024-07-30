import 'package:dio/dio.dart';
import '../../models/Secertary Model/course_trainer_view.dart';
import '../../models/Secertary Model/trainer_course _model.dart';

class TrainerCourseService {
  final Dio _dio = Dio();

  Future<List<TrainerCourse>> fetchTrainerCourses(int trainerId) async {
    try {
      final response = await _dio.get(
        'http://127.0.0.1:8000/api/showtrainerwithcourse/$trainerId',
        options: Options(
          headers: {
            'Authorization': 'Bearer your_token_here',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<TrainerCourse> trainerCourses = (response.data['message'] as List)
            .map((courseJson) => TrainerCourse.fromJson(courseJson))
            .toList();
        return trainerCourses;
      } else {
        throw Exception('Failed to load trainer courses');
      }
    } catch (error) {
      throw Exception('Failed to load trainer courses: $error');
    }
  }

  Future<void> deleteTrainerCourse(int trainerId, int courseId) async {
    try {
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/deletetrainerwithcourse',
        data: {'trainer_id': trainerId, 'course_id': courseId},
        options: Options(
          headers: {
            'Authorization': 'Bearer your_token_here',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete trainer course');
      }
    } catch (error) {
      throw Exception('Failed to delete trainer course: $error');
    }
  }
  Future<List<TrainerByCourse>> fetchTrainersByCourse(int courseId) async {
    try {
      final response = await _dio.get(
        'http://127.0.0.1:8000/api/showtrainerrecordcourse/$courseId',
        options: Options(
          headers: {'Authorization': 'Bearer your_token_here'},
        ),
      );

      if (response.statusCode == 200) {
        List<TrainerByCourse> trainers = (response.data['message'] as List)
            .map((json) => TrainerByCourse.fromJson(json))
            .toList();
        return trainers;
      } else {
        throw Exception('Failed to load trainers');
      }
    } catch (error) {
      throw Exception('Failed to load trainers: $error');
    }
  }
}