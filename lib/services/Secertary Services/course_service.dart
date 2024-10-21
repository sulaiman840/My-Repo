import 'package:dio/dio.dart';
import '../../core/utils/shared_preferences_helper.dart';
import '../../models/Secertary Model/course_model.dart';
import '../../models/notification_data.dart';
import '../notification_service.dart';
import '../token_service.dart';

class CourseService {
  final Dio _dio = Dio();
  final TokenService _tokenService = TokenService();
  final NotificationService _notificationService = NotificationService();

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
    }  on DioError catch (error) {
      print(error.response);

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
          'sessionDoration': course.sessionDuration,
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

      if (response.statusCode == 200) {
        String accessToken = await _tokenService.fetchAccessToken();
        String? managerFcmToken = await _tokenService.fetchFcmTokenByRole('manager');
  //      String? SecetaryFcmToken = await _tokenService.fetchFcmTokenByRole('secretary');
        final bool? manager_falge = await SharedPreferencesHelper.getCheckFlag();

        print(managerFcmToken);
  //      print(SecetaryFcmToken);
        print(manager_falge);

        if (managerFcmToken != null && manager_falge==true) {
          // Send the notification
          await _notificationService.sendNotification(accessToken, managerFcmToken);
          print('Notification has been sent to Manager FCM token successfully');

        } else {
          print('Manager Device token is not turned on yet');
        }
        if (managerFcmToken != null) {
          // Store the notification
          NotificationData notification = NotificationData(
            fcmToken: managerFcmToken,
            title: 'Course Request ',
            body: 'Secertary Added a new Course',
          );

          await _tokenService.storeNotification(notification);}

        print('Course added successfully.');

      }

      else {
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

  Future<List<Course>> searchCourses(String query) async {
    try {
      final token = await SharedPreferencesHelper.getJwtToken();

      final response = await _dio.get(
        'http://127.0.0.1:8000/api/searchcourse/$query',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data as List<dynamic>;
        return responseData.map((item) => Course.fromJson(item)).toList();
      } else {
        throw Exception('Failed to search Courses: ${response.statusCode}');
      }
    } catch (error) {
      if (error is DioError && error.response?.statusCode == 404) {
        throw ('No results found.');
      } else {
        throw Exception('Failed to search Courses: $error');
      }
    }
  }

}
