
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/core/utils/dio_api_service.dart';
import 'package:project2/core/utils/service_locator.dart';
import 'package:project2/screens/Manager_Screens/warehouse/categories/data/repos/category_repo_impl.dart';
import 'package:project2/screens/Manager_Screens/warehouse/categories/presentaion/manager/available_category_cubit/available_category_cubit.dart';
import 'package:project2/screens/Manager_Screens/warehouse/categories/presentaion/manager/un_available_category_cubit/un_available_category_cubit.dart';
import 'package:project2/screens/Manager_Screens/warehouse/data/repos/type_repo_impl.dart';
import 'package:project2/screens/Manager_Screens/warehouse/presentation/manager/create_type_cubit/create_type_cubit.dart';
import 'package:project2/services/manger_profile_service.dart';

import 'Bloc/profile/user_profile_cubit.dart';
import 'Bloc/auth/register_cubit.dart';
import 'services/login_service.dart';
import 'services/manger_profile_service.dart';
import 'core/utils/app_routes.dart';
import 'core/utils/theme_manager.dart';
import 'screens/Manager_Screens/warehouse/categories/presentaion/manager/accept_category_cubit/accept_category_cubit.dart';
import 'screens/Manager_Screens/warehouse/categories/presentaion/manager/category_by_id_cubit/category_by_id_cubit.dart';
import 'screens/Manager_Screens/warehouse/categories/presentaion/manager/create_category_cubit/create_category_cubit.dart';
import 'screens/Manager_Screens/warehouse/categories/presentaion/manager/delete_category_cubit/delete_category_cubit.dart';
import 'screens/Manager_Screens/warehouse/categories/presentaion/manager/get_all_category_cubit/get_all_category_cubit.dart';
import 'screens/Manager_Screens/warehouse/categories/presentaion/manager/reject_category_cubit/reject_category_cubit.dart';
import 'screens/Manager_Screens/warehouse/presentation/manager/delete_type_cubit/delete_type_cubit.dart';
import 'screens/Manager_Screens/warehouse/presentation/manager/get_all_type_cubit/get_all_type_cubit.dart';
import 'screens/Manager_Screens/warehouse/presentation/manager/type_details_cubit/type_details_cubit.dart';
import 'screens/login/login_screen.dart';


import 'screens/home/home_screen.dart';

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
