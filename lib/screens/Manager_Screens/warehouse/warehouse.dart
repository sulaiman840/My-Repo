import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/core/utils/app_manager.dart';
import 'package:project2/core/utils/color_manager.dart';
import 'package:project2/core/utils/style_manager.dart';
import 'package:project2/screens/Manager_Screens/warehouse/categories/presentaion/manager/category_by_id_cubit/category_by_id_cubit.dart';
import 'package:project2/screens/Manager_Screens/warehouse/categories/presentaion/manager/category_by_id_cubit/category_by_id_state.dart';
import 'package:project2/screens/Manager_Screens/warehouse/categories/presentaion/manager/create_category_cubit/create_category_cubit.dart';
import 'package:project2/screens/Manager_Screens/warehouse/categories/presentaion/manager/create_category_cubit/create_category_state.dart';
import 'package:project2/screens/Manager_Screens/warehouse/categories/presentaion/manager/delete_category_cubit/delete_category_cubit.dart';
import 'package:project2/screens/Manager_Screens/warehouse/categories/presentaion/manager/delete_category_cubit/delete_category_state.dart';
import 'package:project2/screens/Manager_Screens/warehouse/categories/presentaion/manager/get_all_category_cubit/get_all_category_cubit.dart';
import 'package:project2/screens/Manager_Screens/warehouse/categories/presentaion/manager/get_all_category_cubit/get_all_category_state.dart';
import 'package:project2/screens/Manager_Screens/warehouse/presentation/manager/get_all_type_cubit/get_all_type_cubit.dart';
import 'package:project2/screens/Manager_Screens/warehouse/presentation/manager/get_all_type_cubit/get_all_type_state.dart';
import 'package:project2/screens/Manager_Screens/warehouse/categories/category_screen.dart';

import 'categories/presentaion/manager/accept_category_cubit/accept_category_cubit.dart';
import 'categories/presentaion/manager/accept_category_cubit/accept_category_state.dart';
import 'categories/presentaion/manager/available_category_cubit/available_category_cubit.dart';
import 'categories/presentaion/manager/available_category_cubit/available_category_state.dart';
import 'categories/presentaion/manager/reject_category_cubit/reject_category_cubit.dart';
import 'categories/presentaion/manager/reject_category_cubit/reject_category_state.dart';
import 'categories/presentaion/manager/un_available_category_cubit/un_available_category_cubit.dart';
import 'categories/presentaion/manager/un_available_category_cubit/un_available_category_state.dart';
import 'presentation/manager/create_type_cubit/create_type_cubit.dart';
import 'presentation/manager/create_type_cubit/create_type_state.dart';
import 'presentation/manager/delete_type_cubit/delete_type_cubit.dart';
import 'presentation/manager/delete_type_cubit/delete_type_state.dart';
import 'presentation/manager/type_details_cubit/type_details_cubit.dart';
import 'presentation/manager/type_details_cubit/type_details_state.dart';
import 'widget/circular_icon_widget.dart';
import 'widget/elevated_btn_widget.dart';
import 'widget/type_item_widget.dart';

class WareHouse extends StatelessWidget {
  const WareHouse({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RejectCategoryCubit, RejectCategoryState>(
      builder: (BuildContext context, state) {
        if (state is RejectCategorySuccess) {
          return Text("show RC");/*Padding(
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
                            Navigator.push(context,MaterialPageRoute(builder: (_)=>CategoryScreen()));
                          },
                        ),

                        separatorBuilder: (context,index)=>const SizedBox(
                          height: AppSize.s20,
                        ),
                        itemCount: state.allTypes.length)),


              ],
            ),
          );*/
        } else if (state is RejectCategoryFailure) {
          return Text(state.errorMessage);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
