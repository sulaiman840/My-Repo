import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/utils/color_manager.dart';
import '../../widgets/manager_home_widgets/custom_app_bar.dart';
import '../../widgets/manager_home_widgets/custom_tab_bar_view.dart';
import '../../widgets/general_widgets/main_nav_bar.dart';
import '../../widgets/general_widgets/search_bar.dart';
import '../../widgets/manager_home_widgets/tab_bar.dart';

class ManagerHome extends StatefulWidget {
  final int tabIndex;

  const ManagerHome({super.key, required this.tabIndex});

  @override
  _ManagerHomeState createState() => _ManagerHomeState();
}

class _ManagerHomeState extends State<ManagerHome> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: widget.tabIndex);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        final newIndex = _tabController.index;
        context.go(context.namedLocation(
          'manager_home',
          queryParameters: {'tab': newIndex.toString()},
        ));
      }
    });
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
                      title: AppLocalizations.of(context).translate('Manager_Dashboard'),
                //      title: 'Manager Dashboard',
                      searchIconColor: ColorManager.bc4,
                      fillColor: ColorManager.bc1,
                    ),
                  ),
                if (!isShortScreen)
                  Container(
                    color: ColorManager.bc1,
                    child: CustomTabBar(tabController: _tabController),
                  ),
                Expanded(
                  child: Container(
                    color: ColorManager.bc1,
                    child: CustomTabBarView(tabController: _tabController),
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
