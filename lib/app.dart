import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:project2/services/Secertary%20Services/beneficiary_service.dart';
import 'package:project2/services/Secertary%20Services/combined_request_service.dart';
import 'package:project2/services/Secertary%20Services/course_service.dart';
import 'package:project2/services/Secertary%20Services/document_service%20.dart';
import 'package:project2/services/Secertary%20Services/pending_beneficiary_service.dart';
import 'package:project2/services/Secertary%20Services/pending_service.dart';
import 'package:project2/services/Secertary%20Services/student_service.dart';
import 'package:project2/services/Secertary%20Services/student_srevice_s.dart';
import 'package:project2/services/auth_services.dart';
import 'package:project2/services/stafflogin_service.dart';

import 'Bloc/auth/register_cubit.dart';
import 'core/utils/app_routes.dart';
import 'core/utils/service_locator.dart';
import 'core/utils/theme_manager.dart';
import 'Bloc/auth/stafflogin_cubit.dart';
import 'Bloc/manager/combined_request_cubit.dart';
import 'Bloc/secertary/course/course_cubit.dart';
import 'Bloc/secertary/course/course_detail_cubit.dart';
import 'Bloc/secertary/course/pending_course_cubit.dart';
import 'Bloc/secertary/student/add_beneficiary_cubit.dart';
import 'Bloc/secertary/student/beneficiary_cubit.dart';
import 'Bloc/secertary/student/document_cubit.dart';
import 'Bloc/secertary/student/pending_beneficiary_cubit.dart';
import 'Bloc/secertary/student/student_cubit.dart';
import 'core/utils/shared_preferences_helper.dart';
import 'Bloc/auth/login_cubit.dart';
import 'Bloc/auth/logout_cubit.dart';
import 'screens/login/login_screen.dart';
import 'screens/staff/data/repos/staff_repo_impl.dart';
import 'screens/staff/presentation/manger/featured_staff_cubit/featured_staff_cubit.dart';
import 'screens/Home/manger_home.dart';

import 'package:project2/services/manger_profile_service.dart';

import 'Bloc/profile/user_profile_cubit.dart';
import 'screens/warehouse_home/category_warehouse/data/repos/category_repo_impl.dart';
import 'screens/warehouse_home/category_warehouse/presentation/manager/create_category_cubit/create_category_cubit.dart';
import 'screens/warehouse_home/category_warehouse/presentation/manager/request_category_cubit/request_category_cubit.dart';
import 'screens/warehouse_home/category_warehouse/presentation/manager/request_items_cubit/request_items_cubit.dart';
import 'screens/warehouse_home/category_warehouse/presentation/manager/update_category_cubit/update_category_cubit.dart';
import 'screens/warehouse_home/type_warehouse/data/repos/type_repo_impl.dart';
import 'screens/warehouse_home/type_warehouse/presentation/manager/create_type_cubit/create_type_cubit.dart';
import 'screens/warehouse_home/type_warehouse/presentation/manager/get_all_type_cubit/get_all_type_cubit.dart';
import 'services/login_service.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserProfileCubit(MangerProfileService())),
        BlocProvider(create: (context) => RegisterCubit(RegisterService())),
        BlocProvider(create: (context) => LoginCubit(LoginService())),
        BlocProvider(create: (context) => LogoutCubit(LoginService())),
        BlocProvider(create: (context) => StaffLoginCubit(StaffLoginService())),
        BlocProvider(create: (context) => CourseCubit(CourseService())),
        BlocProvider(create: (context) => PendingRequestCubit(PendingRequestService())),
        BlocProvider(create: (context) => CourseDetailCubit(CourseService())),
        BlocProvider(create: (context) => PendingBeneficiaryCubit(PendingBeneficiaryService())),
        BlocProvider(create: (context) => BeneficiaryCubit(BeneficiaryService())),
        BlocProvider(create: (context) => DocumentCubit(DocumentService())),
        BlocProvider( create: (context) => CombinedRequestCubit(CombinedRequestService())),
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
        BlocProvider(
          create: (context) {
            return RequestItemsCubit(
              getIt.get<CategoryRepoImpl>(),
            )..fetchRequestItems();
          },
        ),
        BlocProvider(
          create: (context) {
            return RequestCategoryCubit(
              getIt.get<CategoryRepoImpl>(),
            )..fetchRequestCategories();
          },
        ),
      ],
      child: FutureBuilder<bool>(
        future: SharedPreferencesHelper.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data == true) {
            return FutureBuilder<String?>(
              future: SharedPreferencesHelper.getUserRole(),
              builder: (context, roleSnapshot) {
                if (roleSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (roleSnapshot.hasData && roleSnapshot.data != null) {
                  final initialRoute = roleSnapshot.data == "secretary"
                      ? '/secretary_home'
                      : roleSnapshot.data == "warehourseguard"
                      ? '/warehouseHome'
                      : '/';
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: ThemeManager.appTheme,
                    initialRoute: initialRoute,
                    routes: AppRouter.routes,
                  );
                } else {
                  return const LoginScreen();
                }
              },
            );
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeManager.appTheme,
              initialRoute: LoginScreen.id,
              routes: AppRouter.routes,
            );
          }
        },
      ),
    );
  }
}
