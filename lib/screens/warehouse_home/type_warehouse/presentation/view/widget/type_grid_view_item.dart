import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_manager.dart';
import '../../../../../../core/utils/color_manager.dart';
import '../../../../../../core/utils/style_manager.dart';
import '../../../../../../widgets/custom_snack_bar.dart';
import '../../../../../../widgets/icon_btn_widget.dart';
import '../../../data/models/get_all_type_model.dart';
import '../../manager/delete_type_cubit/delete_type_cubit.dart';
import '../../manager/delete_type_cubit/delete_type_state.dart';
import '../../manager/get_all_type_cubit/get_all_type_cubit.dart';

class TypeGridViewItem extends StatelessWidget {
   const TypeGridViewItem({super.key, required this.onTap, required this.allTypeModel});

   final GetAllTypeModel allTypeModel;
   final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteTypeCubit, DeleteTypeState>(
      listener: (contextInner, stateInner) {
        if (stateInner is DeleteTypeFailure) {
          CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('type_deleted_failed'),);
          /*ScaffoldMessenger.of(contextInner).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context).translate('type_deleted_failed'))),
                );*/
        } else if (stateInner is DeleteTypeSuccess) {
          contextInner.read<GetAllTypeCubit>().fetchAllTypes();
          CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('type_deleted_successfully'),);
          /*ScaffoldMessenger.of(contextInner).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context).translate('type_deleted_successfully'))),
                );*/
        }
      },
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
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text(AppLocalizations.of(context).translate('make_sure_delete')),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(AppLocalizations.of(context).translate('cancel')),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context.read<DeleteTypeCubit>().fetchDeleteType(id: allTypeModel.id);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(AppLocalizations.of(context).translate('delete')),
                                    ),
                                  ],
                                );
                              },
                            );
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