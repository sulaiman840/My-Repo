import 'package:flutter/material.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/utils/color_manager.dart';
import '../../widgets/manager_home_widgets/custom_app_bar.dart';
import 'main_nav_bar.dart';
import 'search_bar.dart';
import 'search_bar_scaffold.dart';

class CommonScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CommonScaffold({
    required this.title,
    required this.body,
    required this.scaffoldKey,
    Key? key,
  }) : super(key: key);

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
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context).translate('search_hint_text'),
                  prefixIcon: Icon(Icons.search, color: ColorManager.bc0),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: ColorManager.bc1,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        backgroundColor: ColorManager.bc5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
                    child: SearchBarScaffold(
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