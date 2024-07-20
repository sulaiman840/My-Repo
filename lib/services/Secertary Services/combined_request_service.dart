import 'package:dio/dio.dart';
import '../../core/utils/shared_preferences_helper.dart';
import '../../models/pending_course_model.dart';
import '../../models/pending_beneficiary_request_model.dart';
import '../dio_error.dart';

class CombinedRequestService {
  final Dio _dio = Dio();

  Future<List<PendingRequest>> fetchPendingCourses() async {
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
        print("Courses Response: ${response.data}");
        List<PendingRequest> pendingRequests = (response.data['dataRequest'] as List)
            .map((requestJson) => PendingRequest.fromJson(requestJson))
            .toList();
        return pendingRequests;
      } else {
        throw Exception('Failed to load pending course requests');
      }
    } catch (e) {
      print("Error fetching courses: $e");
      throw Exception(DioErrorHandler.handleError(e));
    }
  }

  Future<List<DataRequest>> fetchPendingBeneficiaries() async {
    try {
      final token = await SharedPreferencesHelper.getJwtToken();
      final response = await _dio.get(
        'http://127.0.0.1:8000/api/showallrequestbeneficiary',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Beneficiaries Response: ${response.data}");
        List<DataRequest> pendingRequests = (response.data['dataRequest'] as List)
            .map((requestJson) => DataRequest.fromJson(requestJson))
            .toList();
        return pendingRequests;
      } else {
        throw Exception('Failed to load pending beneficiary requests');
      }
    } catch (e) {
      print("Error fetching beneficiaries: $e");
      throw Exception(DioErrorHandler.handleError(e));
    }
  }
}
