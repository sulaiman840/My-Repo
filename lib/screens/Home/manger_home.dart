import 'package:flutter/material.dart';
import 'package:project2/core/utils/color_manager.dart';
import '../../widgets/manager_home_widgets/custom_app_bar.dart';
import '../../widgets/manager_home_widgets/custom_tab_bar_view.dart';
import '../../widgets/manager_home_widgets/main_nav_bar.dart';
import '../../widgets/manager_home_widgets/search_bar.dart';
import '../../widgets/manager_home_widgets/tab_bar.dart';

class ManagerHome extends StatefulWidget {
  const ManagerHome({super.key});

  @override
  _ManagerHomeState createState() => _ManagerHomeState();
}

class _ManagerHomeState extends State<ManagerHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isMobile = screenWidth < 600;
    bool isShortScreen = screenHeight < 145;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: isMobile ? CustomAppBar(scaffoldKey: _scaffoldKey) : null,
        drawer: isMobile ? MainNavBar() : null,
        body: Row(
          children: [
            if (!isMobile)
              Container(
                width: 200,
                color: ColorManager.bc5,
                child: MainNavBar(),
              ),
            Expanded(
              child: Column(
                children: [
                  if (!isMobile && !isShortScreen)
                    Container(
                      color: ColorManager.bc0,
                      child: Search_Bar(
                        title: "Manager Dashboard",
                        searchIconColor: ColorManager.bc4,
                        fillColor: ColorManager.bc1,
                      ),
                    ),
                  Expanded(
                    child: Container(
                      color: ColorManager.bc1,
                      child: Column(
                        children: [
                          if (!isShortScreen)
                            CustomTabBar(
                              tabs: [
                                Tab(icon: Icon(Icons.home, size: 16), text: 'Overview'),
                                Tab(icon: Icon(Icons.group, size: 16), text: 'Staff Management'),
                                Tab(icon: Icon(Icons.school, size: 16), text: 'Beneficiary Education'),
                                Tab(icon: Icon(Icons.store, size: 16), text: 'Warehouse'),
                              ],
                            ),
                          Expanded(
                            child: CustomTabBarView(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
