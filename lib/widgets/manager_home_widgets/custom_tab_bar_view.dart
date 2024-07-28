import 'package:flutter/material.dart';

import '../../screens/Manager_Screens/beneficiary_education.dart';
import '../../screens/Manager_Screens/dashboard_overview.dart';
import '../../screens/Manager_Screens/staff_management.dart';
import '../../screens/Manager_Screens/warehouse/warehouse.dart';
import '../../screens/staff/presentation/views/staffs_view.dart';
import '../../screens/type_manager/presentation/view/all_type_view_manager.dart';
import '../../screens/type_warehouse/presentation/view/all_type_view.dart';

class CustomTabBarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        Builder(builder: (context) => DashboardOverview()),
        Builder(builder: (context) => const StaffsView()),
        Builder(builder: (context) => BeneficiaryEducation()),
        Builder(builder: (context) => const AllTypeViewManager()),
      ],
    );
  }
}
