import 'package:flutter/material.dart';
import 'package:project2/screens/staff/presentation/views/staff_details_view.dart';

import '../../screens/staff/presentation/views/staffs_view.dart';



class AppRouter {
  static const String home = '/';
  static const String profile = '/profile';
  static const String staffDetails = '/profile';

  static final routes = <String, WidgetBuilder>{

    staffDetails: (context) => StaffDetailsView(id: 1),




  };
}