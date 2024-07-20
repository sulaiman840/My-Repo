import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bloc/auth/logout_cubit.dart';
import '../../core/utils/app_routes.dart';
import '../../core/utils/color_manager.dart';
import '../../screens/login/login_screen.dart';

class MainNavBar extends StatelessWidget {
  const MainNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Container(
        color: ColorManager.blue2,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('images/logo6.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Youth Empowerment Project',
                      style: TextStyle(
                        color: ColorManager.bc0,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: Colors.white.withOpacity(0.4)),
            Flexible(
              flex: 3,
              child: ListView(
                children: [
                  _buildNavItem(Icons.dashboard, 'Dashboard', context, AppRouter.home),
                  // _buildNavItem(Icons.settings, 'Notifications', context, AppRouter.home),
                  // _buildNavItem(Icons.bar_chart, 'Reports', context, AppRouter.home),
                  // _buildNavItem(Icons.settings, 'Settings', context, AppRouter.home),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.white, size: 30),
                    title: const Text('Logout', style: TextStyle(color: Colors.white, fontSize: 19)),
                    onTap: () {
                      context.read<LogoutCubit>().logout();
                      Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.id, (route) => false);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String title, BuildContext context, String route) {
    bool isSelected = ModalRoute.of(context)?.settings.name == route;

    return Container(
      color: isSelected ? Colors.blue.withOpacity(0.3) : Colors.transparent,
      child: ListTile(
        leading: Icon(icon, color: Colors.white, size: 30),
        title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 19)),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed(route);
        },
      ),
    );
  }
}
