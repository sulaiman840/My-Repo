import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project2/core/utils/app_manager.dart';
import 'package:project2/core/utils/color_manager.dart';
import 'package:project2/core/utils/style_manager.dart';
import 'package:project2/screens/Manager_Screens/warehouse/categories/category_screen.dart';


import 'widget/circular_icon_widget.dart';
import 'widget/elevated_btn_widget.dart';
import 'widget/type_item_widget.dart';

class WareHouse extends StatelessWidget {
  const WareHouse({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
       
          //create new type
      
          elevatedbtn(
            icon: circleIconWidget(icon: Icons.add,
            backgroundColor: ColorManager.orange, color: ColorManager.bc0),
            text: 'Add New Type',
            style: StyleManager.labelMedium(color: ColorManager.bc4),
            onPressed: ()
            {
              //الربط هنا
            },
         
          ),
           
           const SizedBox(height: AppSize.s20,),
          // list of type item
          Expanded(
            child:ListView.separated(
            itemBuilder:(context,index)=> TypeItemWidget(
          //الضغط على العنصر
          onTap: ()
          {
            Navigator.push(context,MaterialPageRoute(builder: (_)=>CategoryScreen()));
            //الربط هنا
          },
        ),
       
            separatorBuilder: (context,index)=>const SizedBox(
              height: AppSize.s20,
            ), 
            itemCount: 5)),
        
      
          ],
      ),
    );
  }
}
