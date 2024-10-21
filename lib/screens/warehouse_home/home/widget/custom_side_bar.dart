// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../Bloc/auth/logout_cubit.dart';
// import '../../../../core/utils/app_routes.dart';
// import '../../../../core/utils/color_manager.dart';
// import '../../../login/login_screen.dart';
//
// class CustomSideBar extends StatelessWidget {
//   const CustomSideBar({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double iconSize = screenWidth > 400 ? 28 : 24;
//     double fontSize = screenWidth > 400 ? 17 : 15;
//
//     return Drawer(
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.zero,
//       ),
//       child: Container(
//         color: ColorManager.blue2,
//         child: Column(
//           children: <Widget>[
//             Flexible(
//               flex: 2,
//               child: Container(
//                 color: ColorManager.blue2,
//                 padding: const EdgeInsets.all(8),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Flexible(
//                       flex: 2,
//                       child: Container(
//                         width: 140,
//                         height: 140,
//                         decoration: const BoxDecoration(
//                           shape: BoxShape.circle,
//                           image: DecorationImage(
//                             image: AssetImage('images/logo6.png'),
//                             fit: BoxFit.contain,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black26,
//                               blurRadius: 10,
//                               offset: Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     const Flexible(
//                       child: Text(
//                         'Youth Empowerment Project',
//                         style: TextStyle(
//                           color: ColorManager.bc0,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 2,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Flexible(
//               flex: 3,
//               child: Material(
//                 color: ColorManager.blue,
//                 child: ListView(
//                   padding: const EdgeInsets.only(top: 20),
//                   children: [
//                     _buildNavItem(
//                       icon: Icons.dashboard,
//                       title: 'Dashboard',
//                       context: context,
//                       route: AppRouter.warehouseHome,
//                       iconSize: iconSize,
//                       fontSize: fontSize,
//                     ),
//                     _buildDivider(),
//                     _buildNavItem(
//                       icon: Icons.bar_chart,
//                       title: 'Reports',
//                       context: context,
//                       route: AppRouter.reportsWarehouse,
//                       iconSize: iconSize,
//                       fontSize: fontSize,
//                     ),
//                     _buildDivider(),
//                   ],
//                 ),
//               ),
//             ),
//             MouseRegion(
//               cursor: SystemMouseCursors.click,
//               child: GestureDetector(
//                 onTap: () {
//                   context.read<LogoutCubit>().logout();
//                   Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.id, (route) => false);
//                 },
//                 child: Material(
//                   color: ColorManager.bluelight,
//                   child: SizedBox(
//                     height: 60,
//                     child: Center(
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(Icons.logout, color: Colors.white, size: iconSize),
//                           const SizedBox(width: 10),
//                           Text(
//                             'Logout',
//                             style: TextStyle(color: Colors.white, fontSize: fontSize),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNavItem({
//     required IconData icon,
//     required String title,
//     required BuildContext context,
//     required String route,
//     required double iconSize,
//     required double fontSize,
//   }) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//       decoration: BoxDecoration(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: ListTile(
//         leading: Icon(icon, color: Colors.white, size: iconSize),
//         title: Text(
//           title,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: fontSize,
//             fontWeight: FontWeight.normal,
//           ),
//         ),
//         onTap: () {
//           Navigator.of(context).pop();
//           Navigator.of(context).pushNamed(route);
//         },
//       ),
//     );
//   }
//
//   Widget _buildDivider() {
//     return const Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16),
//       child: Divider(color: Colors.white24),
//     );
//   }
//   /*Widget build(BuildContext context) {
//     return Drawer(
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.zero,
//       ),
//       child: Container(
//         color: ColorManager.blue2,
//         child: Column(
//           children: <Widget>[
//             Flexible(
//               flex: 2,
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: 140,
//                       height: 140,
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         image: DecorationImage(
//                           image: AssetImage('images/logo6.png'),
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 30),
//                     const Text(
//                       'Youth Empowerment Project',
//                       style: TextStyle(
//                         color: ColorManager.bc0,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Flexible(
//               flex: 3,
//               child: Material(
//                 color: ColorManager.primaryColor,
//                 child: ListView(
//                   children: [
//                     _buildNavItem(Icons.dashboard, 'Dashboard', context, AppRouter.warehouseHome),
//                     Container(height: 0.1, color: ColorManager.blue,),
//                     // _buildNavItem(Icons.settings, 'Notifications', context, AppRouter.home),
//                      _buildNavItem(Icons.error, 'Reports', context, AppRouter.home),
//                     Container(height: 0.1, color: ColorManager.blue,),
//                     // _buildNavItem(Icons.settings, 'Settings', context, AppRouter.home),
//
//                   ],
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 context.read<LogoutCubit>().logout();
//                 Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.id, (route) => false);
//               },
//               child: const Material(
//                 color: ColorManager.blue,
//                 child: SizedBox(
//                   height: 50,
//                   width: 250,
//                   child: Center(
//                     child: Row(
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         SizedBox(width: 80,),
//                         Icon(Icons.logout, color: Colors.white, size: 25),
//                         SizedBox(width: 10,),
//                         Text('Logout', style: TextStyle(color: Colors.white, fontSize: 17)),
//                       ],
//                     )
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNavItem(IconData icon, String title, BuildContext context, String route) {
//     bool isSelected = ModalRoute.of(context)?.settings.name == route;
//
//     return Container(
//       color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
//       height: 60,
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(width: 15,),
//           Icon(icon, color: ColorManager.blue, size: 30),
//           SizedBox(width: 20,),
//           Text(title, style: const TextStyle(color: ColorManager.blue, fontSize: 15)),
//         ],
//       ),*//*ListTile(
//         leading: Icon(icon, color: ColorManager.blue, size: 25),
//         title: Text(title, style: const TextStyle(color: ColorManager.blue, fontSize: 17)),
//         onTap: () {
//           Navigator.of(context).pop();
//           Navigator.of(context).pushNamed(route);
//         },
//       ),*//*
//     );
//   }*/
// }
