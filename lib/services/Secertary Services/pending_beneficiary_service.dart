import 'package:dio/dio.dart';
import '../../core/utils/shared_preferences_helper.dart';
import '../../models/pending_beneficiary_request_model.dart';
import '../dio_error.dart';

class PendingBeneficiaryService {
  final Dio _dio = Dio();
  static const int maxRetries = 3;
  static const int initialDelay = 1000;

  Future<List<DataRequest>> fetchPendingRequests() async {
    final token = await SharedPreferencesHelper.getJwtToken();
    int retries = 0;
    int delay = initialDelay;

    while (true) {
      try {
        final response = await _dio.get(
          'http://127.0.0.1:8000/api/showallrequestbeneficiary',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );

        if (response.statusCode == 200) {
          List<DataRequest> pendingRequests = (response.data['dataRequest'] as List)
              .map((requestJson) => DataRequest.fromJson(requestJson))
              .toList();
          return pendingRequests;
        } else {
          throw Exception('Failed to load pending requests');
        }
      } catch (e) {
        if (e is DioError && e.response?.statusCode == 429) {
          retries++;
          if (retries > maxRetries) {
            throw Exception('Too many requests. Please try again later.');
          }
          await Future.delayed(Duration(milliseconds: delay));
          delay *= 2;
        } else {
          throw Exception(DioErrorHandler.handleError(e));
        }
      }
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
