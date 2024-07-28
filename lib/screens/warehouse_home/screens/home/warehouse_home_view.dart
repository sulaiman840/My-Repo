import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../../../../core/helper/size.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../category_warehouse/presentation/views/all_category_view.dart';
import '../../../type_warehouse/presentation/view/all_type_view.dart';
import '../reports/report_screen.dart';
import 'widget/action_list_widget.dart';
import 'widget/footer_widget.dart';
import 'widget/header_widget.dart';

class WarehouseManagerHome extends StatefulWidget {
  const WarehouseManagerHome({super.key});

  @override
  State<WarehouseManagerHome> createState() => _WarehouseManagerHomeState();
}

class _WarehouseManagerHomeState extends State<WarehouseManagerHome> {
  String _selectedRoute = AllTypeView.id;

  void screenSelector(AdminMenuItem item) {
    setState(() {
      _selectedRoute = item.route!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: ColorManager.primaryColor,
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
          ),
          AdminMenuItem(
            title: 'Send Report',
            route: ReportScreen.id,
            icon: Icons.report,
          ),
        ],
        selectedRoute: _selectedRoute,
        onSelected: (item) {
          screenSelector(item);
        },
        header: const HeaderWidget(),
        footer: const FooterWidget(),
      ),
      body: Scaffold(
        backgroundColor: ColorManager.primaryColor,
        appBar: AppBar(
          backgroundColor: ColorManager.primaryColor,
          title: const Text('WareHouse Manager'),
          actions: action(
            width: getWidth(context) * 0.3,
          ),
        ),
        body: Navigator(
          key: GlobalKey<NavigatorState>(), // Ensure unique key for the Navigator
          onGenerateRoute: (settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case AllTypeView.id:
                builder = (BuildContext _) => const AllTypeView();
                break;
              case AllCategoryView.id:
                builder = (BuildContext _) => const AllCategoryView();
                break;
              case ReportScreen.id:
                builder = (BuildContext _) => const ReportScreen();
                break;
              default:
                throw Exception('Invalid route: ${settings.name}');
            }
            return MaterialPageRoute(builder: builder, settings: settings);
          },
          initialRoute: _selectedRoute,
        ),
      ),
    );
  }
}
