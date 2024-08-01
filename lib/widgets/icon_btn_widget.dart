import 'package:flutter/material.dart';
import 'package:project2/core/utils/app_manager.dart';

class IconBtnWidget extends StatelessWidget {
   IconBtnWidget({super.key,required this.onPressed,required this.icon,required this.color, this.size});

Function()? onPressed;
 IconData? icon;
 Color? color;
 double? size;
  @override
  Widget build(BuildContext context) {
    return  IconButton(
      onPressed:onPressed, 
      icon: Icon(
        icon,
        color:color ,
        size: size?? AppSize.s18,
        ),
        );
  }
}