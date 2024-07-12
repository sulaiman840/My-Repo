import 'package:flutter/material.dart';
import 'package:project2/core/utils/app_manager.dart';
import 'package:project2/core/utils/color_manager.dart';
import 'package:project2/core/utils/style_manager.dart';
import 'package:project2/screens/warehouse_manager/widget/manage_type_item_widget.dart';

import '../../../Manager_Screens/warehouse/widget/circular_icon_widget.dart';
import '../../widget/custom_dialog_widget.dart';
import '../../widget/elevated_btn_widget.dart';
import '../categories/categories_screen.dart';
import 'widget/card_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

 static const String id ='DashboardScreen';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: AppPadding.p30,vertical: AppPadding.p30),
      child: SingleChildScrollView(
        child: Column(
        mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const CardWidget(),
          const SizedBox(
            height: AppSize.s24,
            ),
          
          elevatedbtn(
                      icon: circleIconWidget(icon: Icons.add,
                          backgroundColor: ColorManager.orange, color: ColorManager.bc0),
                      text: 'Add New Type',
                      style: StyleManager.labelMedium(color: ColorManager.bc4),
                      onPressed: ()
                      {
                         openDialog(context: context);
                        //الربط هنا
                      },
                              
                    ),
               
                 const SizedBox( 
                  height: AppSize.s20,
                   ),
        
                 Text('Types',
                       style: StyleManager.h3Bold(color: ColorManager.blackColor),),
                 const SizedBox(
               height: AppSize.s24,
                 ),
        
                
                    ],
        ),
      ),
    );
  }
}