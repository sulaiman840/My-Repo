import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:project2/core/utils/color_manager.dart';

import '../../../../core/helper/size.dart';
import '../../../widgets/manager_home_widgets/custom_app_bar.dart';
import '../../../widgets/manager_home_widgets/main_nav_bar.dart';
import '../../../widgets/manager_home_widgets/search_bar.dart';
import '../category_warehouse/presentation/views/all_category_view.dart';
import '../reports/report_screen.dart';
import '../type_warehouse/presentation/view/all_type_view.dart';
import 'widget/action_list_widget.dart';
import 'widget/footer_widget.dart';
import 'widget/header_widget.dart';


class WarehouseManagerHome extends StatefulWidget {
  const WarehouseManagerHome({super.key});


  @override
  State<WarehouseManagerHome> createState() => _WarehouseManagerHomeState();
}

class _WarehouseManagerHomeState extends State<WarehouseManagerHome> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _selectedScreen = AllTypeView();
  screenSelector(item){
    switch(item.route)
    {
      case AllTypeView.id:
        setState(() {
          _selectedScreen = AllTypeView();
        });
        break;

      case AllCategoryView.id:
        setState(() {
          _selectedScreen = AllCategoryView();
        });
        break;

      case ReportScreen.id:
        setState(() {
          _selectedScreen = const ReportScreen();
        });
        break;
    }
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
          ? CustomAppBar(scaffoldKey: _scaffoldKey)
          : null,
      drawer: isMobile ? MainNavBar() : null,
      body: Row(
        children: [
          if (!isMobile)
            Container(
              width: 200,
              color:  ColorManager.bc5,
              child: MainNavBar(),
            ),
          Expanded(
            child: Column(
              children: [
                if (!isMobile && !isShortScreen)
                  Container(
                    color: ColorManager.bc0,
                    child: Search_Bar(
                      title: 'WareHouse Manager',
                      searchIconColor:ColorManager.bc4,
                      fillColor: ColorManager.bc1,
                    ),
                  ),
                AllTypeView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  /*{
    return AdminScaffold(
        backgroundColor: ColorManager.primaryColor,
        appBar: AppBar(
            backgroundColor: ColorManager.primaryColor,
            title: const Text('WareHouse Manager'),
            actions:action(width:getWidth(context)* 0.3,)),
        sideBar: SideBar(

          backgroundColor: ColorManager.bc0,
          items: const [
            AdminMenuItem(
              title: 'Dashboard',
              route: AllTypeView.id,
              icon: Icons.dashboard,
            ),
            AdminMenuItem(
              title: 'Categories',
              icon: Icons.file_copy,
              route: AllCategoryView.id,
              *//* children: [
              AdminMenuItem(
                title: 'Item 1',
                route: CategoriesScreen.id,
              ),
              AdminMenuItem(
                title: 'Item 2',
                route: CategoriesScreen.id,
              ),
              AdminMenuItem(
                title: 'Third Level',
                children: [
                  AdminMenuItem(
                    title: 'Third Level Item 1',
                    route: '/thirdLevelItem1',
                  ),
                  AdminMenuItem(
                    title: 'Third Level Item 2',
                    route: '/thirdLevelItem2',
                  ),
                ],


              ),
            ],
          *//*),
            AdminMenuItem(
              title: 'Send Report',
              route: ReportScreen.id,
              icon: Icons.report,
            ),
          ],
          selectedRoute: AllTypeView.id,//route
          onSelected: (item)
          {
            screenSelector(item);
          },*//*(item) {
          if (item.route != null) {
            Navigator.of(context).pushNamed(item.route!);
          }
        },*//*

          header: const HeaderWidget(),
          footer:const FooterWidget(),
        ),
        body: SingleChildScrollView(
          child:_selectedScreen,
        )
    );
  }*/
}