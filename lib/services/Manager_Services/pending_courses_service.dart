import 'package:dio/dio.dart';

import '../../core/utils/shared_preferences_helper.dart';
import '../../models/Pending Model/pending_course_model.dart';
import '../dio_error.dart';

class PendingRequestService {
  final Dio _dio = Dio();

  Future<List<PendingRequest>> fetchPendingRequests() async {
    try {
      final token = await SharedPreferencesHelper.getJwtToken();
      final response = await _dio.get(
        'http://127.0.0.1:8000/api/showallrequestCourses',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<PendingRequest> pendingRequests = (response.data['dataRequest'] as List)
            .map((requestJson) => PendingRequest.fromJson(requestJson))
            .toList();
        return pendingRequests;
      } else {
        throw Exception('Failed to load pending requests');
      }
    } catch (e) {
      print(" error: $e");
      throw Exception(DioErrorHandler.handleError(e));
    }
  }

  Future<void> approveRequest(int id) async {
    final token = await SharedPreferencesHelper.getJwtToken();
    try {
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/approverequest/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to approve request');
      }
    } catch (e) {
      throw Exception(DioErrorHandler.handleError(e));
    }
  }

  Future<void> rejectRequest(int id) async {
    final token = await SharedPreferencesHelper.getJwtToken();
    try {
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/rejectrequest/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to reject request');
      }
    } catch (e) {
      throw Exception(DioErrorHandler.handleError(e));
    }
  }
}
