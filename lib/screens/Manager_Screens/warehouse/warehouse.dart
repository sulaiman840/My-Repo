import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/core/utils/app_manager.dart';
import 'package:project2/core/utils/color_manager.dart';
import 'package:project2/core/utils/style_manager.dart';
import 'package:project2/screens/Manager_Screens/warehouse/presentation/manager/get_all_type_cubit/get_all_type_cubit.dart';
import 'package:project2/screens/Manager_Screens/warehouse/presentation/manager/get_all_type_cubit/get_all_type_state.dart';
import '../../../widgets/custom_constrainedb_widget.dart';
import 'widget/category_item_widget.dart';
import '../../warehouse_manager/widget/elevated_btn_widget.dart';
import 'widget/type_item_widget.dart';

class WareHouse extends StatefulWidget {
  const WareHouse({super.key});

  @override
  State<WareHouse> createState() => _WareHouseState();
}



class _WareHouseState extends State<WareHouse> {
  
   int _selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
 return BlocBuilder<GetAllTypeCubit, GetAllTypeState>(
      builder: (BuildContext context, state) 
      {
       if (state is GetAllTypeSuccess) {
          return Row(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: AppPadding.p20),
                child: SizedBox(
                  width:MediaQuery.of(context).size.width/6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [         
                      const SizedBox(height: AppSize.s10,),
                      // list of type item
                      Expanded(
                          child:ListView.separated(
                              itemBuilder:(context,index)=> TypeItemWidget(
                               allTypeModel: state.allTypes[index],
                                //الضغط على العنصر
                                onTap: ()
                                {
                                   setState(() {
                                   _selectedIndex = index;
                                     });
                                  //Navigator.push(context,MaterialPageRoute(builder: (_)=>CategoryScreen()));
                                },
                              ),
                                
                              separatorBuilder: (context,index)=>const SizedBox(
                                height: AppSize.s20,
                              ),
                              itemCount: state.allTypes.length
                              )),
                                
                                
                    ],
                  ),
                ),
              ),
               
               Expanded(
                child: Center(
                 child: _selectedIndex == -1
                ?  Text('Click on type to more ',style: StyleManager.h3Medium(
                  color:ColorManager.blackColor ),)
                :// selectedIndex == index



////////////////////////////////////////Categories///////////////////////////////////////////
                 Card(
                  elevation: 0.0,
                  color: ColorManager.bc0,
                  child:Padding(
                   padding: const EdgeInsetsDirectional.symmetric(horizontal: AppPadding.p24,vertical: AppPadding.p20),
                   child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Categories',style: StyleManager.h1Bold(color: ColorManager.blackColor),),
                      const SizedBox(height: AppSize.s20,),
                      Padding(
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: AppPadding.p30,vertical:AppPadding.p10, ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomConstrainedbWidget(
                          mediaWidth: 4,
                          widget:  elevatedbtn(
                            text: 'Available', 
                            style: StyleManager.body1Medium(color: ColorManager.bc0),
                            radius: AppSize.s12,
                            color: ColorManager.bluelight,
                            onPressed: (){}
                            ),
                         ),
                       
                            CustomConstrainedbWidget(
                          mediaWidth: 4,
                          widget:  elevatedbtn(
                            text: 'Unavailable', 
                            style: StyleManager.body1Medium(color: ColorManager.bc0),
                            radius: AppSize.s12,
                            color: ColorManager.bluelight,
                            onPressed: (){}
                            ),
                         ),
                        ],),
                      ),
                      const SizedBox(height: AppSize.s20,),
                      CategoryItemWidget(),
                    ],
                   ),
                 )
                ),
          ),
        )
            ],
          );
       
          // return Text(state.errorMessage);
        } else {
          return const Center(child: CircularProgressIndicator());
       }

        
      },
    );
  }
}


