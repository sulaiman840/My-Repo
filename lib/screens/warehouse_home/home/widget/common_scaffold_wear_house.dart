import 'package:flutter/material.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../widgets/general_widgets/main_nav_bar.dart';
import '../../../../widgets/general_widgets/search_bar_scaffold.dart';
import 'app_bar_common_scaffold.dart';
import 'custom_side_bar.dart';

class CommonScaffoldWearHouse extends StatelessWidget {
  const CommonScaffoldWearHouse({Key? key, required this.title, required this.body, required this.scaffoldKey}) : super(key: key);

  final String title;
  final Widget body;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isMobile = screenWidth < 650;
    bool isShortScreen = screenHeight < 145;

    return Scaffold(
      key: scaffoldKey,
      appBar: isMobile
          ? AppBar(
        automaticallyImplyLeading: true,
        title: Row(
          children: [
            /*Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search, color: ColorManager.bc0),
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: ColorManager.bc1,
                ),
              ),
            ),*/
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        backgroundColor: ColorManager.bc5,
        /*leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),*/
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
                    child: AppBarCommonScaffold(
                      title: title,
                      searchIconColor: ColorManager.bc4,
                      fillColor: ColorManager.bc1,
                    ),
                  ),
                Expanded(
                  child: Container(
                    color: ColorManager.bc1,
                    child: body,
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
