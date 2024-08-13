import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/Bloc/manager/pending_trainer_cubit.dart';
import 'package:project2/Bloc/secertary/trainer/trainer_course_cubit.dart';
import 'package:project2/screens/staff/data/repos/staff_repo_impl.dart';
import 'package:project2/screens/staff/presentation/manger/featured_staff_cubit/featured_staff_cubit.dart';
import 'package:project2/screens/warehouse_home/category_warehouse/data/repos/category_repo_impl.dart';
import 'package:project2/screens/warehouse_home/category_warehouse/presentation/manager/create_category_cubit/create_category_cubit.dart';
import 'package:project2/screens/warehouse_home/category_warehouse/presentation/manager/request_category_cubit/request_category_cubit.dart';
import 'package:project2/screens/warehouse_home/category_warehouse/presentation/manager/request_items_cubit/request_items_cubit.dart';
import 'package:project2/screens/warehouse_home/category_warehouse/presentation/manager/update_category_cubit/update_category_cubit.dart';
import 'package:project2/screens/warehouse_home/type_warehouse/data/repos/type_repo_impl.dart';
import 'package:project2/screens/warehouse_home/type_warehouse/presentation/manager/create_type_cubit/create_type_cubit.dart';
import 'package:project2/screens/warehouse_home/type_warehouse/presentation/manager/get_all_type_cubit/get_all_type_cubit.dart';
import 'package:project2/services/Manager_Services/education_service.dart';
import 'package:project2/services/Manager_Services/pending_trainer_service.dart';
import 'package:project2/services/Secertary%20Services/beneficiary_course_service.dart';
import 'package:project2/services/Secertary%20Services/beneficiary_service.dart';
import 'package:project2/services/Secertary%20Services/course_service.dart';
import 'package:project2/services/Secertary%20Services/document_service%20.dart';
import 'package:project2/services/Manager_Services/pending_beneficiary_service.dart';
import 'package:project2/services/Manager_Services/pending_courses_service.dart';

import 'package:project2/services/Auth_Services/auth_services.dart';
import 'package:project2/services/Secertary%20Services/trainer_course_service.dart';
import 'package:project2/services/Secertary%20Services/trainer_services.dart';
import 'package:project2/services/stafflogin_service.dart';
import 'Bloc/auth/stafflogin_cubit.dart';
import 'Bloc/manager/education_cubit.dart';
import 'Bloc/notification_cubit.dart'; // Import the NotificationCubit
import 'Bloc/secertary/course/course_cubit.dart';
import 'Bloc/secertary/course/course_detail_cubit.dart';
import 'Bloc/manager/pending_course_cubit.dart';

import 'Bloc/secertary/student/beneficiary_course_cubit.dart';
import 'Bloc/secertary/student/beneficiary_cubit.dart';
import 'Bloc/secertary/student/document_cubit.dart';
import 'Bloc/manager/pending_beneficiary_cubit.dart';

import 'Bloc/secertary/trainer/trainer_cubit.dart';
import 'core/utils/service_locator.dart';
import 'core/utils/shared_preferences_helper.dart';
import 'Bloc/auth/login_cubit.dart';
import 'Bloc/auth/logout_cubit.dart';
import 'Bloc/profile/user_profile_cubit.dart';
import 'Bloc/auth/register_cubit.dart';
import 'services/Auth_Services/login_service.dart';
import 'services/Auth_Services/manger_profile_service.dart';
import 'core/utils/app_routes.dart';
import 'core/utils/theme_manager.dart';
import 'screens/login/login_screen.dart';

import 'screens/home/home_screen.dart';

class MyApp extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({
    Key? key,
    required this.scaffoldMessengerKey,
    required this.navigatorKey,
  }) : super(key: key);

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
        BlocProvider(create: (context) => TrainerCubit(TrainerService())),
        BlocProvider(create: (context) => PendingTrainerCubit(PendingTrainerService())),
        BlocProvider(create: (context) => TrainerCourseCubit(TrainerCourseService())),
        BlocProvider(create: (context) => BeneficiaryCourseCubit(BeneficiaryCourseService())),
        BlocProvider(
          create: (context) => EducationCubit(EducationService())..fetchEducationData(),
        ),
       // BlocProvider.value(value: notificationCubit),

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
                      : '/';
                  return MaterialApp(
                    scaffoldMessengerKey: scaffoldMessengerKey,
                    navigatorKey: navigatorKey,
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
              scaffoldMessengerKey: scaffoldMessengerKey,
              navigatorKey: navigatorKey,
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
