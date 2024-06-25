
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/services/manger_profile_service.dart';

import 'Bloc/profile/user_profile_cubit.dart';
import 'core/utils/app_routes.dart';
import 'core/utils/theme_manager.dart';
import 'screens/login/login_screen.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserProfileCubit(MangerProfileService()),
        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeManager.appTheme,
        initialRoute: LoginScreen.id,
        routes: AppRouter.routes,
        
      ),
    );
  }
}
