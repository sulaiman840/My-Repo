import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:project2/core/utils/dio_api_service.dart';
import 'package:project2/screens/staff/data/repos/staff_repo_impl.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<DioApiService>(
    DioApiService(
        Dio(),
    ),
  );
  getIt.registerSingleton<StaffRepoImpl>(
    StaffRepoImpl(
        getIt.get<DioApiService>(),
    ),
  );
}