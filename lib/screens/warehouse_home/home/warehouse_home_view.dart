import 'package:flutter/material.dart';
import 'package:project2/core/utils/color_manager.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../widgets/general_widgets/main_nav_bar.dart';
import '../../../widgets/general_widgets/search_bar.dart';
import '../type_warehouse/presentation/view/all_type_view.dart';
import 'widget/app_bar_warehouse.dart';
import 'widget/custom_side_bar.dart';


class WarehouseManagerHome extends StatefulWidget {
  const WarehouseManagerHome({super.key});


  @override
  State<WarehouseManagerHome> createState() => _WarehouseManagerHomeState();
}

class _WarehouseManagerHomeState extends State<WarehouseManagerHome> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
        title: Text(AppLocalizations.of(context).translate('warehouse_home_title')),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: AppBarWarehouse(
                title: AppLocalizations.of(context).translate('warehouse_home_title'),
                searchIconColor: ColorManager.bc4,
                fillColor: ColorManager.bc1,
              ),
            ),
          ),
        ],
      )
          : null,
      drawer: isMobile ? const MainNavBar() : null,
      body: Row(
        children: [
          if (!isMobile)
            Container(
              width: 200,
              color: ColorManager.bc5,
              child: const MainNavBar(),
            ),
          Expanded(
            child: Column(
              children: [
                if (!isMobile && !isShortScreen)
                  Container(
                    color: ColorManager.bc0,
                    child: AppBarWarehouse(
                      title: AppLocalizations.of(context).translate('warehouse_home_title'),
                      searchIconColor: ColorManager.bc4,
                      fillColor: ColorManager.bc1,
                    ),
                  ),
                Expanded(child: const AllTypeView()),
              ],
            ),
          ),
        ],
      ),
    );
  }
  /*Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isMobile = screenWidth < 650;
    bool isShortScreen = screenHeight < 145;

    return Scaffold(
      key: _scaffoldKey,
      appBar: isMobile
          ? CustomAppBar(scaffoldKey: _scaffoldKey)
          : null,
      drawer: isMobile ? const CustomSideBar() : null,
      body: Row(
        children: [
          if (!isMobile)
            Container(
              width: 250,
              color:  ColorManager.bc5,
              child: const CustomSideBar(),
            ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  if (!isMobile && !isShortScreen)
                    Container(
                      color: ColorManager.bc0,
                      child: Search_Bar(
                        title: AppLocalizations.of(context).translate('warehouse_home_title'),
                        searchIconColor:ColorManager.bc4,
                        fillColor: ColorManager.bc1,
                      ),
                    ),
                  const AllTypeView(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }*/
}