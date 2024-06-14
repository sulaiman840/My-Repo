import 'package:flutter/material.dart';

import 'screens/Home/ware_house_app.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:WareHouseMApp() ,
    );
  }
}