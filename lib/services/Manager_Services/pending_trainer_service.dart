import 'package:dio/dio.dart';

import '../../core/utils/shared_preferences_helper.dart';
import '../../models/Pending Model/pending_trainer.dart';
import '../dio_error.dart';

class PendingTrainerService {
  final Dio _dio = Dio();

  Future<List<PendingTrainer>> fetchPendingTrainers() async {
    try {
      final token = await SharedPreferencesHelper.getJwtToken();

      final response = await _dio.get(
        'http://127.0.0.1:8000/api/showallrequesttrainer',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<PendingTrainer> pendingTrainers = (response.data['dataRequest'] as List)
            .map((pendingTrainerJson) => PendingTrainer.fromJson(pendingTrainerJson))
            .toList();
        return pendingTrainers;
      } else {
        throw Exception('Failed to load pending trainers');
      }
    } catch (error) {
      throw Exception('Failed to load pending trainers: $error');
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
