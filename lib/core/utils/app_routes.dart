import 'package:flutter/material.dart';
import 'package:project2/screens/staff/presentation/views/staff_details_view.dart';
import 'package:project2/screens/login/login_screen.dart';

import '../../screens/Home/manger_home.dart';
import '../../screens/Manager_Screens/profile_screen.dart';
import '../../screens/register/register_screen.dart';
import '../../screens/staff/presentation/views/staffs_view.dart';

class AppRouter {
  static const String home = '/';
  static const String profile = '/profile';

  static final routes = <String, WidgetBuilder>{
    LoginScreen.id:(context) =>LoginScreen(),
    RegisterScreen.id:(context) =>LoginScreen(),
    home: (context) => ManagerHome(),
    profile: (context) => ProfileScreen(),

      

  };
}

