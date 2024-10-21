// import 'package:flutter/material.dart';
// import '../../core/localization/app_localizations.dart';
// import '../../core/utils/color_manager.dart';
//
// class CustomTabBarSecertary extends StatelessWidget implements PreferredSizeWidget {
//   final TabController tabController;
//
//   CustomTabBarSecertary({required this.tabController});
//
//   @override
//   Size get preferredSize => Size.fromHeight(50.0);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(15.0),
//       alignment: Alignment.centerLeft,
//       child: ConstrainedBox(
//         constraints: BoxConstraints(maxWidth: 700),
//         child: Container(
//           height: 53,
//           decoration: BoxDecoration(
//             color: ColorManager.bc2,
//             borderRadius: BorderRadius.circular(6),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 3,
//                 offset: Offset(0, 1),
//               ),
//             ],
//           ),
//           child: TabBar(
//             padding: EdgeInsetsDirectional.all(4),
//             controller: tabController,
//             isScrollable: false,
//             indicatorSize: TabBarIndicatorSize.tab,
//             indicator: BoxDecoration(
//               color: ColorManager.orange,
//               borderRadius: BorderRadius.circular(6),
//             ),
//             labelColor: Colors.white,
//             unselectedLabelColor: ColorManager.bc3,
//             labelStyle: TextStyle(fontSize: 12),
//             tabs: [
//        //       Tab(icon: Icon(Icons.home, size: 16), text: 'Overview'),
//               Tab(icon: Icon(Icons.school, size: 16), text: AppLocalizations.of(context).translate('courses_management')),
//               Tab(icon: Icon(Icons.person, size: 16), text: AppLocalizations.of(context).translate('beneficiary_title')),
//               Tab(icon: Icon(Icons.group, size: 16), text: AppLocalizations.of(context).translate('trainers_management')),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../core/utils/color_manager.dart';
import '../../core/localization/app_localizations.dart';

class CustomTabBarSecertary extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;

  CustomTabBarSecertary({required this.tabController});

  @override
  Size get preferredSize => const Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Container(
      margin: const EdgeInsets.all(15.0),
      alignment: isRtl ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 750),
        child: Container(
          height: 53,
          decoration: BoxDecoration(
            color: ColorManager.bc2,
            borderRadius: BorderRadius.circular(6),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: TabBar(
            padding: const EdgeInsetsDirectional.all(4),
            controller: tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: ColorManager.orange,
              borderRadius: BorderRadius.circular(6),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: ColorManager.bc3,
            labelStyle: const TextStyle(fontSize: 12),
            tabs: [
              Tab(icon: Icon(Icons.school, size: 16), text: AppLocalizations.of(context).translate('courses_management')),
              Tab(icon: Icon(Icons.person, size: 16), text: AppLocalizations.of(context).translate('beneficiary_title')),
              Tab(icon: Icon(Icons.group, size: 16), text: AppLocalizations.of(context).translate('trainers_management')),

            ],
          ),
        ),
      ),
    );
  }
}
