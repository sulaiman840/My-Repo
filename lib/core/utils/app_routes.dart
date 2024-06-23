
import 'package:flutter/material.dart';

import '../../screens/Home/manger_home.dart';
import '../../screens/Manager_Screens/profile_screen.dart';


class AppRouter {
  static const String home = '/';
  static const String profile = '/profile';

  static final routes = <String, WidgetBuilder>{
    home: (context) => ManagerHome(),
    profile: (context) => ProfileScreen(),

  };
}
