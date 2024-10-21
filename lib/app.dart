import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/Bloc/manager/pending_trainer_cubit.dart';
import 'package:project2/Bloc/secertary/trainer/trainer_course_cubit.dart';
import 'package:project2/core/localization/app_localizations_setup.dart';
import 'package:project2/screens/Manager_Screens/warehouse/request_manager/data/repos/request_repo_impl.dart';
import 'package:project2/screens/Manager_Screens/warehouse/request_manager/presentation/manager/request_category_cubit/request_category_cubit.dart';
import 'package:project2/screens/Manager_Screens/warehouse/request_manager/presentation/manager/request_items_cubit/request_items_cubit.dart';
import 'package:project2/screens/staff/data/repos/staff_repo_impl.dart';
import 'package:project2/screens/staff/presentation/manger/featured_staff_cubit/featured_staff_cubit.dart';
import 'package:project2/screens/warehouse_home/category_warehouse/data/repos/category_repo_impl.dart';
import 'package:project2/screens/warehouse_home/category_warehouse/presentation/manager/create_category_cubit/create_category_cubit.dart';
import 'package:project2/screens/warehouse_home/category_warehouse/presentation/manager/update_category_cubit/update_category_cubit.dart';
import 'package:project2/screens/warehouse_home/item_warehouse/data/repos/item_repo_impl.dart';
import 'package:project2/screens/warehouse_home/item_warehouse/presentation/manager/consume_item_cubit/consume_item_cubit.dart';
import 'package:project2/screens/warehouse_home/reports/data/repos/report_repo_impl.dart';
import 'package:project2/screens/warehouse_home/reports/presentation/manager/create_report_cubit/create_report_cubit.dart';
import 'package:project2/screens/warehouse_home/reports/presentation/manager/get_file_cubit/get_file_cubit.dart';
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
import 'Bloc/notification_cubit.dart';
import 'Bloc/secertary/course/course_cubit.dart';
import 'Bloc/secertary/course/course_detail_cubit.dart';
import 'Bloc/manager/pending_course_cubit.dart';
import 'Bloc/secertary/student/beneficiary_course_cubit.dart';
import 'Bloc/secertary/student/beneficiary_cubit.dart';
import 'Bloc/secertary/student/beneficiary_excel_cubit.dart';
import 'Bloc/secertary/student/document_cubit.dart';
import 'Bloc/manager/pending_beneficiary_cubit.dart';
import 'Bloc/secertary/trainer/trainer_cubit.dart';
import 'Bloc/user_role_cubit .dart';
import 'core/localization/local_cubit/local_cubit.dart';
import 'core/utils/app_routes.dart';
import 'core/utils/service_locator.dart';
import 'Bloc/auth/login_cubit.dart';
import 'Bloc/auth/logout_cubit.dart';
import 'Bloc/profile/user_profile_cubit.dart';
import 'Bloc/auth/register_cubit.dart';
import 'screens/staff/presentation/manger/delete_staff_cubit/delete_staff_cubit.dart';
import 'screens/warehouse_home/category_warehouse/presentation/manager/delete_category_cubit/delete_category_cubit.dart';
import 'screens/warehouse_home/item_warehouse/presentation/manager/delete_item_cubit/delete_item_cubit.dart';
import 'screens/warehouse_home/item_warehouse/presentation/manager/export_to_excel_cubit/export_to_excel_cubit.dart';
import 'screens/warehouse_home/reports/presentation/manager/delete_report_cubit/delete_report_cubit.dart';
import 'screens/warehouse_home/type_warehouse/presentation/manager/delete_type_cubit/delete_type_cubit.dart';
import 'services/Auth_Services/login_service.dart';
import 'services/Auth_Services/manger_profile_service.dart';
import 'core/utils/theme_manager.dart';

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
        BlocProvider(create: (context) => BeneficiaryExcelCubit(BeneficiaryService())),
        BlocProvider(create: (context) => EducationCubit(EducationService())..fetchEducationData()),
        BlocProvider(
          create: (context) => UserRoleCubit()..fetchUserRole(),
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
            return DeleteStaffCubit(
              getIt.get<StaffRepoImpl>(),
            );
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
            return DeleteTypeCubit(
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
            return DeleteCategoryCubit(
              getIt.get<CategoryRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return DeleteItemCubit(
              getIt.get<ItemRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return DeleteReportCubit(
              getIt.get<ReportRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return RequestItemsCubit(
              getIt.get<RequestRepoImpl>(),
            )..fetchRequestItems();
          },
        ),
        BlocProvider(
          create: (context) {
            return RequestCategoryCubit(
              getIt.get<RequestRepoImpl>(),
            )..fetchRequestCategories();
          },
        ),
        BlocProvider(
          create: (context) => ConsumeItemCubit(
            getIt.get<ItemRepoImpl>(),
          ),
        ),
        BlocProvider(
          create: (context) {
            return CreateReportCubit(
              getIt.get<ReportRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return GetFileCubit(
              getIt.get<ReportRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) => ExportToExcelCubit(
            getIt.get<ItemRepoImpl>(),
          ),
        ),
        BlocProvider<LocaleCubit>(create: (_) => LocaleCubit()),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp.router(
            routerDelegate: AppRouter.router.routerDelegate,
            routeInformationParser: AppRouter.router.routeInformationParser,
            routeInformationProvider: AppRouter.router.routeInformationProvider,
            scaffoldMessengerKey: scaffoldMessengerKey,
            theme: ThemeManager.appTheme,
            debugShowCheckedModeBanner: false,
            supportedLocales: AppLocalizationsSetup.supportedLocales,
            localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
            localeResolutionCallback: AppLocalizationsSetup.localeResolutionCallback,
            locale: locale,
          );
        },
      ),
    );
  }
}
