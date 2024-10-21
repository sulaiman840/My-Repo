import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc/notification_cubit.dart';
import 'app.dart';
import 'firebase_messaging_service.dart';
import 'firebase_options.dart';
import 'core/utils/service_locator.dart';
import 'core/utils/bloc_ob_server.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final navigatorKey = GlobalKey<NavigatorState>();

  await Firebase.initializeApp(
    options: firebaseOptions,
  );
  await FirebaseMessagingService.initialize(scaffoldMessengerKey, navigatorKey);
  setupServiceLocator();
  Bloc.observer = MyBlocObserver();

  runApp(MyApp(
    scaffoldMessengerKey: scaffoldMessengerKey,
    navigatorKey: navigatorKey,
  ));
}
// import 'package:flutter/material.dart';
// import 'package:project2/screens/login/login_screen.dart';
// import '../../screens/Home/home_screen.dart';
// import '../../screens/Home/manger_home.dart';
// import '../../screens/Home/notifications_screen.dart';
// import '../../screens/Home/secretary_home.dart';
// import '../../screens/Manager_Screens/profile_screen.dart';
// import '../../screens/login/stafflogin_screen.dart';
// import '../../screens/register/register_screen.dart';
// import '../../screens/warehouse_home/home/warehouse_home_view.dart';
//
//
// class AppRouter {
//
//   static const String home = '/';
//   static const String secretary_home = '/secretary_home';
//   static const String profile = '/profile';
//   static const String warehouseHome = '/warehouseHome';
//   static const String notifications = '/notifications_screen';
//   static final routes = <String, WidgetBuilder>{
//
//     LoginScreen.id:(context) =>LoginScreen(),
//     RegisterScreen.id:(context) =>LoginScreen(),
//     StaffLoginScreen.id:(context) =>StaffLoginScreen(),
//
//
//
//     home: (context) => ManagerHome(),
//
//     secretary_home: (context) => SecretaryHome(),
//     profile: (context) => ProfileScreen(),
//     warehouseHome: (context) => const WarehouseManagerHome(),
//     // notifications: (context) =>  NotificationScreen(),
//
//
//
//   };
// }
//