import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/core/utils/app_manager.dart';
import 'package:project2/core/utils/color_manager.dart';
import 'package:project2/core/utils/style_manager.dart';
import 'package:project2/screens/Manager_Screens/warehouse/presentation/manager/get_all_type_cubit/get_all_type_cubit.dart';
import 'package:project2/screens/Manager_Screens/warehouse/presentation/manager/get_all_type_cubit/get_all_type_state.dart';


import 'widget/circular_icon_widget.dart';
import 'widget/elevated_btn_widget.dart';
import 'widget/type_item_widget.dart';

class WareHouse extends StatelessWidget {
  const WareHouse({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllTypeCubit, GetAllTypeState>(
      builder: (BuildContext context, state) {
        if (state is GetAllTypeSuccess) {
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
                          allTypeModel: state.allTypes[index],
                          //الضغط على العنصر
                          onTap: ()
                          {
                            //الربط هنا
                          },
                        ),

                        separatorBuilder: (context,index)=>const SizedBox(
                          height: AppSize.s20,
                        ),
                        itemCount: state.allTypes.length)),


              ],
            ),
          );
        } else if (state is GetAllTypeFailure) {
          return Text(state.errorMessage);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
