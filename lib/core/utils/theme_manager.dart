import 'package:flutter/material.dart';
import 'package:project2/core/utils/color_manager.dart';

class ThemeManager{
  static final ThemeData appTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: ColorManager.primaryColor,
    primarySwatch: ColorManager.primarySwatchColor,
   
    scaffoldBackgroundColor:ColorManager.scaffoldBackgroundColor
  );
}