import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../screens/warehouse_home/category_warehouse/data/repos/category_repo_impl.dart';
import '../../screens/warehouse_home/item_warehouse/data/repos/item_repo_impl.dart';
import '../../screens/staff/data/repos/staff_repo_impl.dart';
import '../../screens/warehouse_home/type_warehouse/data/repos/type_repo_impl.dart';
import 'dio_api_service.dart';

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
  getIt.registerSingleton<TypeRepoImpl>(
    TypeRepoImpl(
      getIt.get<DioApiService>(),
    ),
  );

  getIt.registerSingleton<CategoryRepoImpl>(
    CategoryRepoImpl(
      getIt.get<DioApiService>(),
    ),
  );

  getIt.registerSingleton<ItemRepoImpl>(
    ItemRepoImpl(
      getIt.get<DioApiService>(),
    ),
  );
}