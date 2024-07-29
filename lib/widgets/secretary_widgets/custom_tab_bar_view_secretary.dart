
import 'package:flutter/material.dart';

import '../../screens/Manager_Screens/beneficiary_education.dart';
import '../../screens/Manager_Screens/dashboard_overview.dart';
import '../../screens/Manager_Screens/staff_management.dart';
import '../../screens/Secertary_Screens/coach_management.dart';
import '../../screens/Secertary_Screens/Course/course_management.dart';
import '../../screens/Secertary_Screens/Student/student_management.dart';

class CustomTabBarViewSecertary extends StatelessWidget {
  final TabController tabController;

  CustomTabBarViewSecertary({required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        DashboardOverview(),
        CourseManagementScreen(),
        BeneficiaryManagementScreen(),
        CoachManagementScreen(),
      ],
    );
  }
}
