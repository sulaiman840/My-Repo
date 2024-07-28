import 'package:flutter/material.dart';
import '../../core/utils/color_manager.dart';

class CustomTabBarSecertary extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;

  CustomTabBarSecertary({required this.tabController});

  @override
  Size get preferredSize => Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 700),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: ColorManager.bc2,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: TabBar(
            padding: EdgeInsetsDirectional.all(4),
            controller: tabController,
            isScrollable: false,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: ColorManager.orange,
              borderRadius: BorderRadius.circular(6),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: ColorManager.bc3,
            labelStyle: TextStyle(fontSize: 12),
            tabs: [
              Tab(icon: Icon(Icons.home, size: 16), text: 'Overview'),
              Tab(icon: Icon(Icons.school, size: 16), text: 'Courses Management'),
              Tab(icon: Icon(Icons.person, size: 16), text: 'Beneficiary Management'),
              Tab(icon: Icon(Icons.group, size: 16), text: 'Coach Management'),
            ],
          ),
        ),
      ),
    );
  }
}
