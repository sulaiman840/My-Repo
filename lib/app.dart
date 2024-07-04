import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/core/utils/dio_api_service.dart';
import 'package:project2/core/utils/service_locator.dart';
import 'package:project2/screens/staff/data/repos/staff_repo_impl.dart';
import 'package:project2/screens/staff/presentation/manger/featured_staff_cubit/featured_staff_cubit.dart';
import 'screens/Home/ware_house_app.dart';
import 'screens/staff/presentation/views/staff_details_view.dart';
import 'screens/staff/presentation/views/staffs_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return FeaturedStaffCubit(
                getIt.get<StaffRepoImpl>(),
            )..fetchFeaturedStaff();
          },
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:StaffsView() ,
      ),
    );
  }
}