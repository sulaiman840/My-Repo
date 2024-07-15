import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:project2/core/utils/color_manager.dart';
import 'package:project2/screens/warehouse_manager/screens/categories/categories_screen.dart';
import 'package:project2/screens/warehouse_manager/screens/reports/report_screen.dart';

import '../../../../core/helper/size.dart';
import '../dashboard/dashboard_screen.dart';
import 'widget/action_list_widget.dart';
import 'widget/footer_widget.dart';
import 'widget/header_widget.dart';


class WarehouseManagerHome extends StatefulWidget {
   
  
  
  
  @override
  State<WarehouseManagerHome> createState() => _WarehouseManagerHomeState();
}

class _WarehouseManagerHomeState extends State<WarehouseManagerHome> {
  Widget _selectedScreen = const DashboardScreen();
  screenSelector(item){
    switch(item.route)
    {
      case DashboardScreen.id:
      setState(() {
        _selectedScreen = DashboardScreen();
      });
      break;

      case CategoriesScreen.id:
         setState(() {
        _selectedScreen = CategoriesScreen();
      });
      break;

      case ReportScreen.id:
         setState(() {
        _selectedScreen = ReportScreen();
      });
      break;
    }
  }
  @override
  Widget build(BuildContext context) {
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
            route: DashboardScreen.id,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Categories',
            icon: Icons.file_copy,
            route: CategoriesScreen.id,
           /* children: [
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
          */),
          AdminMenuItem(
            title: 'Send Report',
            route: ReportScreen.id,
            icon: Icons.report,
          ),
        ],
        selectedRoute: DashboardScreen.id,//route
        onSelected: (item)
        {
           screenSelector(item);
        },/*(item) {        
          if (item.route != null) {
            Navigator.of(context).pushNamed(item.route!);
          }
        },*/
        
        header: const HeaderWidget(),
        footer:const FooterWidget(),
        ),
      body: SingleChildScrollView(
        child:_selectedScreen,
    )
    );
  }
}

