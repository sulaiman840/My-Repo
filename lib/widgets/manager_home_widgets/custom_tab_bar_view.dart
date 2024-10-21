
import 'package:flutter/material.dart';
import 'package:project2/screens/Manager_Screens/Request_Managmenet_Screen/request_managment.dart';

import '../../screens/Manager_Screens/Education_Screen/education_screen.dart';
import '../../screens/Manager_Screens/dashboard_overview.dart';
import '../../screens/Manager_Screens/staff_management.dart';
import '../../screens/Manager_Screens/warehouse/old/warehouse.dart';
import '../../screens/Manager_Screens/warehouse/type_manager/presentation/view/all_type_view_manager.dart';
import '../../screens/staff/presentation/views/staffs_view.dart';

class CustomTabBarView extends StatelessWidget {
  final TabController tabController;

  CustomTabBarView({required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [

        EducationScreen(),

        StaffsView(),
        AllTypeViewManager(),
        RequestManagementScreen()

        WareHouse(),
      RequestManagementScreen()
    ],
    );
  }
}
