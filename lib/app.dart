import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/core/utils/dio_api_service.dart';
import 'package:project2/core/utils/service_locator.dart';
import 'package:project2/screens/Manager_Screens/warehouse/data/repos/type_repo_impl.dart';
import 'package:project2/services/manger_profile_service.dart';
import 'Bloc/profile/user_profile_cubit.dart';
import 'core/utils/app_routes.dart';
import 'core/utils/theme_manager.dart';
import 'screens/Manager_Screens/warehouse/presentation/manager/get_all_type_cubit/get_all_type_cubit.dart';
import 'screens/login/login_screen.dart';
import 'package:project2/screens/staff/data/repos/staff_repo_impl.dart';
import 'package:project2/screens/staff/presentation/manger/featured_staff_cubit/featured_staff_cubit.dart';
import 'screens/Home/ware_house_app.dart';
import 'screens/staff/presentation/views/staff_details_view.dart';
import 'screens/staff/presentation/views/staffs_view.dart';
import 'screens/warehouse_manager/screens/home/warehouse_manager_home.dart';

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
            return GetAllTypeCubit(
              getIt.get<TypeRepoImpl>(),
            );//..fetchAllTypes();
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeManager.appTheme,
        home:WarehouseManagerHome() ,
        //edit it , please
       // initialRoute: WarehouseManagerHome.id,
        //routes: AppRouter.routes,
        
      ),
    );
  }
}
