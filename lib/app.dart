import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/services/manger_profile_service.dart';
import 'Bloc/profile/user_profile_cubit.dart';
import 'core/utils/service_locator.dart';
import 'core/utils/theme_manager.dart';
import 'screens/Home/manger_home.dart';

import 'screens/category_warehouse/data/repos/category_repo_impl.dart';
import 'screens/category_warehouse/presentation/manager/create_category_cubit/create_category_cubit.dart';
import 'screens/category_warehouse/presentation/manager/update_category_cubit/update_category_cubit.dart';
import 'screens/staff/data/repos/staff_repo_impl.dart';
import 'screens/staff/presentation/manger/featured_staff_cubit/featured_staff_cubit.dart';
import 'screens/type_warehouse/data/repos/type_repo_impl.dart';
import 'screens/type_warehouse/presentation/manager/create_type_cubit/create_type_cubit.dart';
import 'screens/type_warehouse/presentation/manager/get_all_type_cubit/get_all_type_cubit.dart';
import 'screens/warehouse_home/screens/home/warehouse_home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserProfileCubit(MangerProfileService()),
        ),
        BlocProvider(
          create: (context) {
            return FeaturedStaffCubit(
              getIt.get<StaffRepoImpl>(),
            )..fetchFeaturedStaff();
          },
        ),
        BlocProvider(
          create: (context) {
            return GetAllTypeCubit(
              getIt.get<TypeRepoImpl>(),
            )..fetchAllTypes();
          },
        ),
        BlocProvider(
          create: (context) {
            return CreateTypeCubit(
              getIt.get<TypeRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return CreateCategoryCubit(
              getIt.get<CategoryRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return UpdateCategoryCubit(
              getIt.get<CategoryRepoImpl>(),
            );
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeManager.appTheme,
        home: const ManagerHome() ,
        //edit it , please
       // initialRoute: WarehouseManagerHome.id,
        //routes: AppRouter.routes,
        
      ),
    );
  }
}
