import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  CustomAppBar({required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
      ),
      actions: [
        IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
      ],
      backgroundColor: Colors.white,
      elevation: 4,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
