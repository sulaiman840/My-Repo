import 'package:flutter/material.dart';

import '../../screens/Manager_Screens/beneficiary_education.dart';
import '../../screens/Manager_Screens/dashboard_overview.dart';
import '../../screens/Manager_Screens/staff_management.dart';
import '../../screens/Manager_Screens/warehouse.dart';

class CustomTabBarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        Builder(builder: (context) => DashboardOverview()),
        Builder(builder: (context) => StaffManagement()),
        Builder(builder: (context) => BeneficiaryEducation()),
        Builder(builder: (context) => WareHouse()),
      ],
    );
  }
}
