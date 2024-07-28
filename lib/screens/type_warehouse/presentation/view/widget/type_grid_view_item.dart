import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_manager.dart';
import '../../../../../../core/utils/color_manager.dart';
import '../../../../../../core/utils/style_manager.dart';
import '../../../../../../widgets/icon_btn_widget.dart';
import '../../../data/models/get_all_type_model.dart';
import '../../manager/delete_type_cubit/delete_type_cubit.dart';
import '../../manager/delete_type_cubit/delete_type_state.dart';

class TypeGridViewItem extends StatelessWidget {
   const TypeGridViewItem({super.key, required this.onTap, required this.allTypeModel});

   final GetAllTypeModel allTypeModel;
   final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeleteTypeCubit, DeleteTypeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints.tightFor(
                  width: MediaQuery.of(context).size.width/6,
                  height: 165.0
                ),
                padding:const EdgeInsetsDirectional.symmetric(
                  vertical: AppPadding.p16,
                  horizontal: AppPadding.p16,
                ),
                decoration: BoxDecoration(
                  color: ColorManager.bc2,
                  borderRadius: BorderRadius.circular(AppSize.s12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Spacer(),
                        /*IconBtnWidget(
                        onPressed: ()
                        {
                          openDialog(
                            context: context,
                            title: 'Add new type',
                            hintText: 'Enter name',
                            controller: typeController,
                            onPressed: (){
                              final deleteCubit = context.read<DeleteTypeCubit>();
                              Navigator.pop(context);
                            }
                          );
                        },
                        icon: Icons.edit,
                        color: ColorManager.blue2,
                      ),*/
                        IconBtnWidget(
                          onPressed: ()
                          {
                            DeleteTypeCubit.get(context).fetchDeleteType(id: allTypeModel.id);
                          },
                          icon: Icons.delete,
                          color: ColorManager.orange,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSize.s20,),
                    //name
                    Center(
                      child: Text(
                        allTypeModel.name,
                        style: StyleManager.body1SemiBold(color: ColorManager.blackColor),
                      ),
                    ),
                    const SizedBox(height: AppSize.s50,),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}