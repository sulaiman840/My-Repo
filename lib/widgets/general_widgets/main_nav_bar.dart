import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../Bloc/auth/logout_cubit.dart';
import '../../Bloc/user_role_cubit .dart';
import '../../core/utils/color_manager.dart';
import '../../core/localization/app_localizations.dart';

class MainNavBar extends StatelessWidget {
  const MainNavBar({super.key});

  Future<void> _navigateBasedOnRole(BuildContext context, String? role) async {
    if (role == "secretary") {
      context.go('/secretary_home');
    } else if (role == "manager") {
      context.go('/manager_home');
    } else if (role == "warehouseguard") {
      context.go('/warehouseHome');
    } else {
      context.go('/');
    }
  }

  Future<void> _navigateReportBasedOnRole(BuildContext context, String? role) async {
    if (role == "warehouseguard") {
      context.go('/reports_warehouse');
    } else if (role == "manager") {
      context.go('/reports_manager');
    } else {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = screenWidth > 400 ? 28 : 24;
    double fontSize = screenWidth > 400 ? 17 : 15;

    return BlocBuilder<UserRoleCubit, String?>(
      builder: (context, role) {
        if (role == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Drawer(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          child: Container(
            color: ColorManager.blue2,
            child: Column(
              children: <Widget>[
                _buildHeader(context),
                _buildNavItems(context, iconSize, fontSize, role),
                _buildLogout(context, iconSize, fontSize),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Container(
        color: ColorManager.blue2,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: AssetImage('images/logo6.png'),
                    fit: BoxFit.contain,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Flexible(
              child: Text(
                AppLocalizations.of(context).translate('youth_empowerment_project'),
                style: const TextStyle(
                  color: ColorManager.bc0,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItems(BuildContext context, double iconSize, double fontSize, String? role) {
    return Flexible(
      flex: 3,
      child: Material(
        color: ColorManager.blue,
        child: ListView(
          padding: const EdgeInsets.only(top: 20),
          children: [
            _buildNavItem(
              icon: Icons.dashboard,
              title: AppLocalizations.of(context).translate('dashboard'),
              context: context,
              iconSize: iconSize,
              fontSize: fontSize,
              onTap: () => _navigateBasedOnRole(context, role),
            ),
            _buildDivider(),
            _buildNavItem(
              icon: Icons.person,
              title: AppLocalizations.of(context).translate('profile'),
              context: context,
              route: '/profile',
              iconSize: iconSize,
              fontSize: fontSize,
            ),
            _buildDivider(),
            if (role != "secretary") ...[
              _buildNavItem(
                icon: Icons.bar_chart,
                title: AppLocalizations.of(context).translate('report_title'),
                context: context,
                iconSize: iconSize,
                fontSize: fontSize,
                onTap: () => _navigateReportBasedOnRole(context, role),
              ),
              _buildDivider(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLogout(BuildContext context, double iconSize, double fontSize) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          context.read<LogoutCubit>().logout();
          context.go('/');
        },
        child: Material(
          color: ColorManager.bluelight,
          child: SizedBox(
            height: 60,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.logout, color: Colors.white, size: iconSize),
                  const SizedBox(width: 10),
                  Text(
                    AppLocalizations.of(context).translate('logout'),
                    style: TextStyle(color: Colors.white, fontSize: fontSize),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String title,
    required BuildContext context,
    String? route,
    required double iconSize,
    required double fontSize,
    VoidCallback? onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ListTile(
        leading: Icon(icon, color: Colors.white, size: iconSize),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
          ),
        ),
        onTap: onTap ??
                () {
              if (route != null) {
                context.go(route);
              }
            },
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(color: Colors.white24),
    );
  }
}
