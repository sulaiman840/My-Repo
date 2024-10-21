import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project2/screens/Manager_Screens/warehouse/reports/presentation/views/all_report_view_m.dart';
import 'package:project2/screens/Secertary_Screens/Student/pending_beneficiary_screen.dart';
import 'package:project2/screens/Secertary_Screens/Trainer/pending_trainer_screen.dart';
import 'package:project2/screens/login/login_screen.dart';
import 'package:project2/screens/Home/home_screen.dart';
import 'package:project2/screens/Home/secretary_home.dart';
import 'package:project2/screens/Manager_Screens/profile_screen.dart';
import 'package:project2/screens/warehouse_home/home/warehouse_home_view.dart';
import 'package:project2/screens/warehouse_home/reports/presentation/views/all_report_view.dart';
import '../../Bloc/secertary/course/course_cubit.dart';
import '../../Bloc/secertary/student/beneficiary_cubit.dart';
import '../../Bloc/secertary/trainer/trainer_cubit.dart';
import '../../models/Pending Model/pending_beneficiary_request_model.dart';
import '../../models/Pending Model/pending_course_model.dart';
import '../../models/Pending Model/pending_trainer.dart';
import '../../models/Secertary Model/beneficiary_model.dart';
import '../../screens/Home/manger_home.dart';
import '../../screens/Home/notifications_screen.dart';
import '../../screens/Home/search_screen.dart';
import '../../screens/Manager_Screens/Education_Screen/Beneficiaries_Education_Screen/beneficiaries_education_screen.dart';
import '../../screens/Manager_Screens/Education_Screen/Courses_Education_Screen/courses_education_screen.dart';
import '../../screens/Manager_Screens/Education_Screen/Trainer_Manager_Education/trainers_education_screen.dart';
import '../../screens/Manager_Screens/Education_Screen/Trainer_Manager_Education/trainer_details_education_screen.dart';
import '../../screens/Manager_Screens/Request_Managmenet_Screen/beneficiary_edit_manager_screen.dart';
import '../../screens/Manager_Screens/warehouse/category_manager/presentation/views/all_category_view_manager.dart';
import '../../screens/Manager_Screens/warehouse/category_manager/presentation/views/all_child_category_view_m.dart';
import '../../screens/Manager_Screens/warehouse/item_manager/presentation/views/all_item_view_manager.dart';
import '../../screens/Manager_Screens/warehouse/item_manager/presentation/views/search_view_manager.dart';
import '../../screens/Manager_Screens/warehouse/reports/presentation/views/report_details_view_m.dart';
import '../../screens/Manager_Screens/warehouse/request_manager/data/models/all_request_category_model.dart';
import '../../screens/Manager_Screens/warehouse/request_manager/data/models/all_request_item_model.dart';
import '../../screens/Manager_Screens/warehouse/request_manager/presentation/view/request_category_details_view.dart';
import '../../screens/Manager_Screens/warehouse/request_manager/presentation/view/request_item_details_view.dart';
import '../../screens/login/stafflogin_screen.dart';
import 'package:project2/screens/Secertary_Screens/Course/pending_course_sreen.dart';
import 'package:project2/screens/Secertary_Screens/Course/course_detail_screen.dart';
import 'package:project2/screens/Secertary_Screens/Student/beneficiary_details_screen.dart';
import 'package:project2/screens/Secertary_Screens/Trainer/trainer_details.dart';
import 'package:project2/screens/Secertary_Screens/Student/update_beneficiary_dialog.dart';
import 'package:project2/screens/Secertary_Screens/Student/add_beneficiary_screen.dart';
import 'package:project2/screens/Manager_Screens/Request_Managmenet_Screen/course_detail_manager_screen.dart';
import 'package:project2/screens/Manager_Screens/Request_Managmenet_Screen/beneficiary_detail_manager_screen.dart';
import 'package:project2/screens/Manager_Screens/Request_Managmenet_Screen/traner_details_manager_screen.dart';
import '../../screens/Manager_Screens/Education_Screen/Courses_Education_Screen/course_detail_education.dart';
import '../../screens/Manager_Screens/Education_Screen/Beneficiaries_Education_Screen/beneficiary_details_education_screen.dart';
import '../../screens/staff/data/models/show_all_staff_model.dart';
import '../../screens/staff/presentation/views/create_staff_view.dart';
import '../../screens/staff/presentation/views/staff_details_view.dart';
import '../../screens/staff/presentation/views/update_staff_view.dart';
import '../../screens/warehouse_home/category_warehouse/data/models/get_all_category_model.dart';
import '../../screens/warehouse_home/category_warehouse/presentation/views/all_category_view.dart';
import '../../screens/warehouse_home/category_warehouse/presentation/views/all_child_category_view.dart';
import '../../screens/warehouse_home/item_warehouse/data/models/all_items_model.dart';
import '../../screens/warehouse_home/item_warehouse/data/models/expiring_soon_items_model.dart';
import '../../screens/warehouse_home/item_warehouse/data/models/search_items_model.dart';
import '../../screens/warehouse_home/item_warehouse/presentation/views/all_items_view.dart';
import '../../screens/warehouse_home/item_warehouse/presentation/views/create_item_view.dart';
import '../../screens/warehouse_home/item_warehouse/presentation/views/item_details_view.dart';
import '../../screens/warehouse_home/item_warehouse/presentation/views/search_view.dart';
import '../../screens/warehouse_home/item_warehouse/presentation/views/update_item_view.dart';
import '../../screens/warehouse_home/reports/presentation/views/report_details_view.dart';
import '../../services/Secertary Services/beneficiary_service.dart';
import '../../services/Secertary Services/course_service.dart';
import '../../services/Secertary Services/trainer_services.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/manager_home',
        name: 'manager_home',
        builder: (context, state) {
          final tabIndex =
              int.tryParse(state.uri.queryParameters['tab'] ?? '0') ?? 0;
          return ManagerHome(tabIndex: tabIndex);
        },
      ),
      GoRoute(
        path: '/secretary_home',
        name: 'secretary_home',
        builder: (context, state) {
          final tabIndex =
              int.tryParse(state.uri.queryParameters['tab'] ?? '0') ?? 0;
          return SecretaryHome(tabIndex: tabIndex);
        },
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => ProfileScreen(),
      ),
      GoRoute(
        path: '/reports_warehouse',
        builder: (context, state) => AllReportView(),
      ),
      GoRoute(
        path: '/reports_manager',
        builder: (context, state) => AllReportViewM(),
      ),
      GoRoute(
        path: '/warehouseHome',
        builder: (context, state) => const WarehouseManagerHome(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/stafflogin',
        builder: (context, state) => const StaffLoginScreen(),
      ),
      //secertary
      GoRoute(
        path: '/pending_course',
        builder: (context, state) => const PendingCourseScreen(),
      ),
      GoRoute(
        path: '/pending_trainer',
        builder: (context, state) => const PendingTrainerScreen(),
      ),
      GoRoute(
        path: '/pending_beneficiary',
        builder: (context, state) => const PendingBeneficiaryScreen(),
      ),
      GoRoute(
        path: '/course_detail/:id',
        builder: (context, state) {
          final courseId = int.parse(state.pathParameters['id']!);
          return CourseDetailScreen(courseId: courseId);
        },
      ),
      GoRoute(
        path: '/update_beneficiary',
        builder: (context, state) {
          final beneficiary = (state.extra as Map)['beneficiary'] as DataBeneficiary;
          final callback = (state.extra as Map)['callback'] as VoidCallback;
          return BeneficiaryUpdateScreen(
            beneficiary: beneficiary,
            onPop: callback,
          );
        },
      ),
      GoRoute(
        path: '/beneficiary_detail/:id',
        builder: (context, state) {
          final beneficiaryId = int.parse(state.pathParameters['id']!);
          return BeneficiaryDetailsScreen(beneficiaryId: beneficiaryId);
        },
      ),
      GoRoute(
        path: '/trainer_detail/:id',
        builder: (context, state) {
          final trainerId = int.parse(state.pathParameters['id']!);
          return TrainerDetailsScreen(trainerId: trainerId);
        },
      ),
      GoRoute(
        path: '/add_beneficiary',
        builder: (context, state) {
          //    final beneficiary = (state.extra as Map)['beneficiary'] as DataBeneficiary;
          final callback = (state.extra as Map)['callback'] as VoidCallback;
          return BeneficiaryCreateScreen(
            // beneficiary: beneficiary,
            onBeneficiaryAdded: callback,
          );
        },
      ),
      //manager
      GoRoute(
        path: '/course_detail_manager/:id',
        builder: (context, state) {
          final pendingRequest = state.extra as PendingRequest;
          return CourseDetailManagerScreen(pendingRequest: pendingRequest);
        },
      ),
      GoRoute(
        path: '/course_detail_education/:id',
        builder: (context, state) {
          final courseId = int.parse(state.pathParameters['id']!);
          return CourseDetailEducation(courseId: courseId);
        },
      ),
      GoRoute(
        path: '/beneficiary_detail_education/:id',
        builder: (context, state) {
          final beneficiaryId = int.parse(state.pathParameters['id']!);
          return BeneficiaryDetailsEducationScreen(
              beneficiaryId: beneficiaryId);
        },
      ),
      GoRoute(
        path: '/beneficiary_detail_manager/:id',
        builder: (context, state) {
          final pendingRequest = state.extra as DataRequest;
          return BeneficiaryDetailManagerScreen(pendingRequest: pendingRequest);
        },
      ),
      GoRoute(
        path: '/trainer_detail_education/:id',
        builder: (context, state) {
          final trainerId = int.parse(state.pathParameters['id']!);
          return TrainerDetailsEducationScreen(trainerId: trainerId);
        },
      ),
      GoRoute(
        path: '/trainer_detail_manager/:id',
        builder: (context, state) {
          final pendingTrainer = state.extra as PendingTrainer;
          return TranerDetailsManagerScreen(pendingTrainer: pendingTrainer);
        },
      ),


      GoRoute(
        path: '/beneficiary_edit_manager',
        builder: (context, state) {
          final beneficiary = (state.extra as Map)['beneficiary'] as DataRequest;
          final callback = (state.extra as Map)['callback'] as VoidCallback;
          return BeneficiaryEditManagerScreen(
            beneficiary: beneficiary,
            onPop: callback,
          );
        },
      ),





      GoRoute(
        path: '/courses_education',
        builder: (context, state) => const CoursesEducationScreen(),
      ),
      GoRoute(
        path: '/beneficiaries_education',
        builder: (context, state) => const BeneficiariesEducationScreen(),
      ),
      GoRoute(
        path: '/trainers_education',
        builder: (context, state) => const TrainersEducationScreen(),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) {
          final query = state.uri.queryParameters['q'] ?? '';
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => BeneficiaryCubit(BeneficiaryService())
                  ..searchBeneficiaries(query),
              ),
              BlocProvider(
                create: (context) =>
                    TrainerCubit(TrainerService())..searchTrainers(query),
              ),
              BlocProvider(
                create: (context) =>
                    CourseCubit(CourseService())..searchCourses(query),
              ),
            ],
            child: SearchScreen(query: query),
          );
        },
      ),
      GoRoute(
        path: '/search_bar_scaffold',
        builder: (context, state) {
          final query = state.uri.queryParameters['q'] ?? '';
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => BeneficiaryCubit(BeneficiaryService())
                  ..searchBeneficiaries(query),
              ),
              BlocProvider(
                create: (context) =>
                    TrainerCubit(TrainerService())..searchTrainers(query),
              ),
              BlocProvider(
                create: (context) =>
                    CourseCubit(CourseService())..searchCourses(query),
              ),
            ],
            child: SearchScreen(query: query),
          );
        },
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) {
          final userId = (state.extra as Map<String, dynamic>)['userId'] as int;
          return NotificationScreen(userId: userId);
        },
      ),

      //WearHouse guard routes
      GoRoute(path: '/AllCategoryView/:typeId', builder: (context, state) => AllCategoryView(
          typeId: int.parse(state.pathParameters["typeId"]!),
        )
      ),
      GoRoute(path: '/AllChildCategoryView/:typeId', builder: (context, state) => AllChildCategoryView(
          typeId: int.parse(state.pathParameters["typeId"]!),
          childCategory: state.extra as List<GetAllCategoryModel>,
        )
      ),
      GoRoute(path: '/AllItemsView/:typeId/:categoryId', builder: (context, state) => AllItemsView(
          typeId: int.parse(state.pathParameters["typeId"]!),
          categoryId: int.parse(state.pathParameters["categoryId"]!),
        )
      ),
      GoRoute(path: '/CreateItemView/:typeId/:categoryId', builder: (context, state) => CreateItemView(
          typeId: int.parse(state.pathParameters["typeId"]!),
          categoryId: int.parse(state.pathParameters["categoryId"]!),
        )
      ),
      GoRoute(path: '/SearchView/:typeId/:categoryId', builder: (context, state) => SearchView(
          typeId: int.parse(state.pathParameters["typeId"]!),
          categoryId: int.parse(state.pathParameters["categoryId"]!),
        )
      ),
      GoRoute(path: '/ItemDetailsView/:id', builder: (context, state) => ItemDetailsView(
          id: int.parse(state.pathParameters["id"]!),
        )
      ),
      GoRoute(path: '/UpdateItemView', builder: (context, state) {
        DataView dataView = state.extra as DataView;
          return UpdateItemView(
              allItems: dataView,
          );
        }
      ),
      GoRoute(path: '/UpdateExpiringItemView', builder: (context, state) {
        DataExpiring dataExpiring = state.extra as DataExpiring;
          return UpdateExpiringItemView(
              allItems: dataExpiring,
          );
        }
      ),
      GoRoute(path: '/UpdateSearchItemView', builder: (context, state) {
        DataSearch dataSearch = state.extra as DataSearch;
          return UpdateSearchItemView(
              allItems: dataSearch,
          );
        }
      ),
      GoRoute(path: '/ReportDetailsView/:id', builder: (context, state) {
          return ReportDetailsView(
              id: int.parse(state.pathParameters["id"]!),
          );
        }
      ),
      GoRoute(path: '/StaffDetailsView/:id', builder: (context, state) {
          return StaffDetailsView(
              id: int.parse(state.pathParameters["id"]!),
          );
        }
      ),
      GoRoute(path: '/UpdateStaffView', builder: (context, state) {
        ShowAllStaffModel showAllStaffModel = state.extra as ShowAllStaffModel;
          return UpdateStaffView(
              allStaff: showAllStaffModel,
          );
        }
      ),
      GoRoute(path: '/CreateStaffView', builder: (context, state) {
          return CreateStaffView();
        }
      ),
      GoRoute(path: '/AllCategoryViewManager/:typeId', builder: (context, state) {
          return AllCategoryViewManager(
            typeId: int.parse(state.pathParameters['typeId']!),
          );
        }
      ),
      GoRoute(path: '/AllItemViewManager/:typeId/:categoryId', builder: (context, state) {
          return AllItemViewManager(
            typeId: int.parse(state.pathParameters['typeId']!),
            categoryId: int.parse(state.pathParameters['categoryId']!),
          );
        }
      ),
      GoRoute(path: '/AllChildCategoryViewM/:typeId', builder: (context, state) {
          return AllChildCategoryViewM(
            typeId: int.parse(state.pathParameters['typeId']!),
            childCategory: state.extra as List<GetAllCategoryModel>,
          );
        }
      ),
      GoRoute(path: '/SearchViewManager/:typeId/:categoryId', builder: (context, state) {
          return SearchViewManager(
            typeId: int.parse(state.pathParameters['typeId']!),
            categoryId: int.parse(state.pathParameters['categoryId']!),
          );
        }
      ),
      GoRoute(path: '/ReportDetailsViewM/:id', builder: (context, state) {
          return ReportDetailsViewM(
            id: int.parse(state.pathParameters['id']!),
          );
        }
      ),
      GoRoute(path: '/RequestCategoryDetailsView', builder: (context, state) {
        DataRequestCategory dataRequestCategory = state.extra as DataRequestCategory;
          return RequestCategoryDetailsView(
            allRequestCategory: dataRequestCategory,
          );
        }
      ),
      GoRoute(path: '/RequestItemDetailsView', builder: (context, state) {
        DataRequestItem dataRequestItem = state.extra as DataRequestItem;
          return RequestItemDetailsView(
            allRequestItem: dataRequestItem,
          );
        }
      ),
    ],
  );
}
