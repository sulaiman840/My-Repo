import 'package:flutter/material.dart';
import 'package:project2/core/utils/color_manager.dart';

class MainNavBar extends StatelessWidget {
  const MainNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Container(
        color: ColorManager.blue,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                margin: EdgeInsetsDirectional.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('images/logo.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Youth Empowerment Project',
                      style: TextStyle(
                        color: ColorManager.bluelight,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 150,
                      height: 75,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: AssetImage('images/sy.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              Divider(color: Colors.white.withOpacity(0.4)),
              _buildNavItem(Icons.dashboard, 'Dashboard', context),
              _buildNavItem(Icons.bar_chart, 'Reports', context),
              _buildNavItem(Icons.settings, 'Settings', context),
              _buildNavItem(Icons.logout, 'Logout', context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String title, BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white, size: 30),
      title: Text(title, style: TextStyle(color: Colors.white, fontSize: 19)),
      onTap: () => Navigator.of(context).pop(),
    );
  }
}
