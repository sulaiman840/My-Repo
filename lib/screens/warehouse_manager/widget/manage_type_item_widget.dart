import 'package:flutter/material.dart';
import 'package:project2/screens/Manager_Screens/warehouse/data/models/get_all_type_model.dart';
import '../../../../core/utils/app_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../widgets/icon_btn_widget.dart';

class TypeItemWidget extends StatelessWidget {
   TypeItemWidget({super.key,required this.onTap,
   // required this.allTypeModel
    });

   //final GetAllTypeModel allTypeModel;
  
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
              width: MediaQuery.of(context).size.width/6),
            padding:const EdgeInsetsDirectional.symmetric(
              vertical: AppPadding.p16,
              horizontal: AppPadding.p16
              ),
            decoration: BoxDecoration(
              color: ColorManager.bc0,
              borderRadius: BorderRadius.circular(AppSize.s12)
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                  Row(      
                     mainAxisSize: MainAxisSize.min,
      
                    children: [
                    const Spacer(),
                    // edit icon
                     
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
                  Center(child: Text('name of type',style: StyleManager.body1SemiBold(color: ColorManager.blackColor),)),
                  const SizedBox(height: AppSize.s50,),
              ],
            ),
          )
        ],),
    );
  }
}