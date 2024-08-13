import 'package:flutter/material.dart';
import 'package:project2/screens/login/login_screen.dart';

import '../../screens/Home/home_screen.dart';
import '../../screens/Home/manger_home.dart';
import '../../screens/Home/notifications_screen.dart';
import '../../screens/Home/secretary_home.dart';
import '../../screens/Manager_Screens/profile_screen.dart';
import '../../screens/login/stafflogin_screen.dart';
import '../../screens/register/register_screen.dart';
import '../../screens/warehouse_home/home/warehouse_home_view.dart';

class AppRouter {
  static const String home = '/';
  static const String secretary_home = '/secretary_home';
  static const String profile = '/profile';
  static const String warehouseHome = '/warehouseHome';
  static const String notifications = '/notifications_screen';
  static final routes = <String, WidgetBuilder>{

    LoginScreen.id:(context) =>LoginScreen(),
    RegisterScreen.id:(context) =>LoginScreen(),
    StaffLoginScreen.id:(context) =>StaffLoginScreen(),



    home: (context) => ManagerHome(),

    secretary_home: (context) => SecretaryHome(),
    profile: (context) => ProfileScreen(),
    warehouseHome: (context) => const WarehouseManagerHome(),
    notifications: (context) =>  NotificationScreen(),



  };
}

