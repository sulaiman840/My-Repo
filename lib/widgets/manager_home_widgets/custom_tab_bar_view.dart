
import 'package:flutter/material.dart';
import 'package:project2/screens/Manager_Screens/request_managment.dart';

import '../../screens/Manager_Screens/beneficiary_education.dart';
import '../../screens/Manager_Screens/dashboard_overview.dart';
import '../../screens/Manager_Screens/staff_management.dart';
import '../../screens/Manager_Screens/warehouse/warehouse.dart';
import '../../screens/staff/presentation/views/staffs_view.dart';
import '../../screens/type_manager/presentation/view/all_type_view_manager.dart';
import '../../screens/type_warehouse/presentation/view/all_type_view.dart';

class CustomTabBarView extends StatelessWidget {
  final TabController tabController;

  CustomTabBarView({required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        DashboardOverview(),
        StaffManagement(),
        BeneficiaryEducation(),
        AllTypeViewManager(),
        RequestManagementScreen()
      ],
    );
  }
}
