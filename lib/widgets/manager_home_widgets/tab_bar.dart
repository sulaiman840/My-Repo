import 'package:flutter/material.dart';
import 'package:project2/core/utils/color_manager.dart';

class CustomTabBar extends StatelessWidget {
  final List<Tab> tabs;

  CustomTabBar({required this.tabs});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 600,
        ),
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
            isScrollable: false,
            indicatorSize: TabBarIndicatorSize.tab,
            padding: EdgeInsetsDirectional.all(4),
            indicator: BoxDecoration(
              color: ColorManager.orange,
              borderRadius: BorderRadius.circular(6),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: ColorManager.bc3,
            labelStyle: TextStyle(fontSize: 12),
            tabs: tabs,
          ),
        ),
      ),
    );
  }
}
