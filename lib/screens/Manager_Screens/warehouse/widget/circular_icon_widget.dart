import 'package:flutter/material.dart';
import 'package:project2/core/utils/color_manager.dart';

import '../../../../core/utils/app_manager.dart';

circleIconWidget({required IconData icon, Color? color,Color? backgroundColor})=> CircleAvatar(
                            backgroundColor:backgroundColor?? ColorManager.blue2,
                             radius:AppSize.s14,//s18 ,
                             child:Icon(
                               icon,
                             color:color?? ColorManager.bc0,
                             size: AppSize.s12,)
                             
                            /*  IconBtnWidget(
                                      icon:icon, //Icons.add,
                                      color:color,// white,
                                      size: AppSize.s12,
                              ),*/
                           );

