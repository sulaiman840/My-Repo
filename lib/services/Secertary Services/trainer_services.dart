import 'package:dio/dio.dart';
import '../../core/utils/shared_preferences_helper.dart';
import '../../models/Secertary Model/trainer_course_registration.dart';
import '../../models/Secertary Model/trainer_model.dart';
import '../../models/notification_data.dart';
import '../notification_service.dart';
import '../token_service.dart';

class TrainerService {
  final Dio _dio = Dio();
  final TokenService _tokenService = TokenService();
  final NotificationService _notificationService = NotificationService();
  Future<List<Trainer>> fetchTrainers() async {
    try {
      final response = await _dio.get(
        'http://127.0.0.1:8000/api/showalltrainer',
        options: Options(
          headers: {
            'Authorization': 'Bearer your_token_here',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<Trainer> trainers = (response.data['message'] as List)
            .map((trainerJson) => Trainer.fromJson(trainerJson))
            .toList();
        return trainers;
      } else {
        throw Exception('Failed to load trainers');
      }
    } catch (error) {
      throw Exception('Failed to load trainers: $error');
    }
  }

  Future<Trainer> fetchTrainerDetail(int id) async {
    try {
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/showtrainer/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer your_token_here',
          },
        ),
      );

      if (response.statusCode == 200) {
        return Trainer.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load trainer detail');
      }
    } catch (error) {
      throw Exception('Failed to load trainer detail: $error');
    }
  }


  Future<void> deleteTrainer(int id) async {
    try {
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/destroytrainer/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer your_token_here',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete trainer');
      }
    } catch (error) {
      throw Exception('Failed to delete trainer: $error');
    }
  }

  Future<void> updateTrainer(int id, Trainer trainer) async {
    try {
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/updateTrainer/$id',
        data: trainer.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer your_token_here',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update trainer');
      }
    } on DioError catch (error) {
      throw Exception('Failed to update trainer: $error');
    }
  }
  Future<void> addTrainer(Trainer trainer) async {
    try {
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/addtrainer',
        data: trainer.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer your_token_here',
          },
        ),
      );

      if (response.statusCode == 200) {
        String accessToken = await _tokenService.fetchAccessToken();
        String? managerFcmToken = await _tokenService.fetchFcmTokenByRole('manager');
        final bool? manager_falge = await SharedPreferencesHelper.getCheckFlag();
        print(managerFcmToken);

        print(manager_falge);

        if (managerFcmToken != null && manager_falge==true) {
          // Send the notification
          await _notificationService.sendNotification(accessToken, managerFcmToken);
          print('Notification has been sent to Manager FCM token successfully');

        } else {
          print('Manager Device is not  turned on yet');
        }
        if (managerFcmToken != null) {
          // Store the notification
          NotificationData notification = NotificationData(
            fcmToken: managerFcmToken,
            title: 'Trainer Request ',
            body: 'Secertary Added a new Trainer',
          );

          await _tokenService.storeNotification(notification);}

        print('Trainer added successfully.');

      }
    } catch (error) {
      throw Exception('Failed to add trainer: $error');
    }
  }

  Future<void> registerTrainerInCourse(TrainerCourseRegistration registration) async {
    try {
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/trainerwithcourse',
        data: registration.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer your_token_here',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to register trainer in course');
      }
    } catch (error) {
      throw Exception('Failed to register trainer in course: $error');
    }
  }



  Future<List<TrainerCourseRegistration>> fetchTrainerDetailWithCourses(int id) async {
    try {
      final response = await _dio.get(
        'http://127.0.0.1:8000/api/showtrainerwithcourse/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer your_token_here',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<TrainerCourseRegistration> registrations = (response.data['message'] as List)
            .map((json) => TrainerCourseRegistration.fromJson(json))
            .toList();
        return registrations;
      } else {
        throw Exception('Failed to load trainer details');
      }
    } catch (error) {
      throw Exception('Failed to load trainer details: $error');
    }
  }

  Future<void> deleteTrainerFromCourse(int trainerId, int courseId) async {
    try {
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/deletetrainerwithcourse',
        data: {
          'trainer_id': trainerId.toString(),
          'course_id': courseId.toString(),
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer your_token_here',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete trainer from course');
      }
    } catch (error) {
      throw Exception('Failed to delete trainer from course: $error');
    }
  }

  Future<List<Trainer>> searchTrainers(String query) async {
    try {
      final token = await SharedPreferencesHelper.getJwtToken();

      final response = await _dio.get(
        'http://127.0.0.1:8000/api/searchtrainer/$query',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data as List<dynamic>;
        return responseData.map((item) => Trainer.fromJson(item)).toList();
      } else {
        throw Exception('Failed to search Trainer: ${response.statusCode}');
      }
    } catch (error) {
      if (error is DioError && error.response?.statusCode == 404) {
        throw ('No results found.');
      } else {
        throw Exception('Failed to search Trainer: $error');
      }
    }
  }

}