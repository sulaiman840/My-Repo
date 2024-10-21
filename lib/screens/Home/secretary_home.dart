import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../Bloc/secertary/student/beneficiary_cubit.dart';
import '../../Bloc/secertary/student/beneficiary_state.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/utils/color_manager.dart';
import '../../services/Secertary Services/beneficiary_service.dart';

import '../../widgets/general_widgets/main_nav_bar.dart';
import '../../widgets/general_widgets/search_bar.dart';
import '../../widgets/secretary_widgets/custom_tab_bar_view_secretary.dart';
import '../../widgets/secretary_widgets/tab_bar_secertary.dart';

class SecretaryHome extends StatefulWidget {
  final int tabIndex;
  const SecretaryHome({super.key, required this.tabIndex});

  @override
  _SecretaryHomeState createState() => _SecretaryHomeState();
}

class _SecretaryHomeState extends State<SecretaryHome> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this,initialIndex: widget.tabIndex);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        final newIndex = _tabController.index;
        context.go(context.namedLocation(
          'secretary_home',
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
      appBar: isMobile
          ? AppBar(
        title: Text(AppLocalizations.of(context).translate('secretary_dashboard')),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Search_Bar(
                title: AppLocalizations.of(context).translate('secretary_dashboard'),
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
                      title: AppLocalizations.of(context).translate('secretary_dashboard'),
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


