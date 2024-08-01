import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bloc/secertary/student/beneficiary_cubit.dart';
import '../../Bloc/secertary/student/beneficiary_state.dart';
import '../../core/utils/color_manager.dart';
import '../../services/Secertary Services/beneficiary_service.dart';

import '../../widgets/manager_home_widgets/main_nav_bar.dart';
import '../../widgets/manager_home_widgets/search_bar.dart';
import '../../widgets/secretary_widgets/custom_tab_bar_view_secretary.dart';
import '../../widgets/secretary_widgets/tab_bar_secertary.dart';

class SecretaryHome extends StatefulWidget {
  const SecretaryHome({super.key});

  @override
  _SecretaryHomeState createState() => _SecretaryHomeState();
}

class _SecretaryHomeState extends State<SecretaryHome> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isMobile = screenWidth < 650;
    bool isShortScreen = screenHeight < 145;

    return Scaffold(
      key: _scaffoldKey,
      appBar: isMobile
          ? AppBar(
        title: Text('Secretary Dashboard'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Search_Bar(
                title: 'Secretary Dashboard',
                searchIconColor: ColorManager.bc4,
                fillColor: ColorManager.bc1,
              ),
            ),
          ),
        ],
      )
          : null,
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
                      title: 'Secretary Dashboard',
                      searchIconColor: ColorManager.bc4,
                      fillColor: ColorManager.bc1,
                    ),
                  ),
                if (!isShortScreen)
                  Container(
                    color: ColorManager.bc1,
                    child: CustomTabBarSecertary(tabController: _tabController),
                  ),
                Expanded(
                  child: Container(
                    color: ColorManager.bc1,
                    child: CustomTabBarViewSecertary(tabController: _tabController),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


