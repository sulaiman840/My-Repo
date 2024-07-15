import 'package:flutter/material.dart';

import '../../../../core/utils/app_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../widgets/icon_btn_widget.dart';

class ManageCategoryItemWidget extends StatelessWidget {
   ManageCategoryItemWidget({super.key});

  
  Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
         children: [
          Container(
            constraints: BoxConstraints.tightFor(
              width: MediaQuery.of(context).size.width/8),
            padding:const EdgeInsetsDirectional.symmetric(
              vertical: AppPadding.p16,
              horizontal: AppPadding.p16
              ),
            decoration: BoxDecoration(
              color: ColorManager.primaryColor,
              borderRadius: BorderRadius.circular(AppSize.s12),
              border: Border.all(color: ColorManager.orangeLight)
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                  Row(      
                     mainAxisSize: MainAxisSize.min,
                    children: [
                    const Spacer(),
                    IconBtnWidget(
                      onPressed: ()
                      {
                        //الربط هنا 
                      },
                      icon: Icons.edit,
                      color: ColorManager.blue2,
                    ),
                    // delelte icon
                    IconBtnWidget(
                      onPressed: ()
                      {
                        //الربط هنا 
                      },
                      icon: Icons.delete,
                      color: ColorManager.orange,
                    ),
                  ],),
                  const SizedBox(height: AppSize.s20,),
                  //name
                  Center(child: Text('category',style: StyleManager.body1SemiBold(color: ColorManager.blackColor),)),
                  const SizedBox(height: AppSize.s30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                     [//فورمات للتاريخ 
                      // DateFormat.yMMMd().format(DateTime.parse((model.created_at)))
                     Text('created at ',style: StyleManager.labelRegular(color: ColorManager.bc3),),
                     Text('updated at',style: StyleManager.labelRegular(color: ColorManager.bc3),)
                    ],
                  ),
              ],
            ),
          )
        ],),
    );
  }

}