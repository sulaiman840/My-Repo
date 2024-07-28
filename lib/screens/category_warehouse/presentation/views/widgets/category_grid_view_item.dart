import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/utils/app_manager.dart';
import '../../../../../../../core/utils/color_manager.dart';
import '../../../../../../../core/utils/service_locator.dart';
import '../../../../../../../core/utils/style_manager.dart';
import '../../../../../../../widgets/icon_btn_widget.dart';
import '../../../../warehouse_home/widget/custom_dialog_widget.dart';
import '../../../data/models/get_all_category_model.dart';
import '../../../data/repos/category_repo_impl.dart';
import '../../manager/delete_category_cubit/delete_category_cubit.dart';
import '../../manager/update_category_cubit/update_category_cubit.dart';

class CategoryGridViewItem extends StatelessWidget {
  CategoryGridViewItem({super.key, required this.onTap, required this.allCategoryModel});

  final GetAllCategoryModel allCategoryModel;
  final Function()? onTap;
  final TextEditingController typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints.tightFor(
              width: MediaQuery.of(context).size.width/6,
              height: 165.0,
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
                    BlocProvider(
                      create: (context) {
                        return UpdateCategoryCubit(
                          getIt.get<CategoryRepoImpl>(),
                        );
                      },
                      child: IconBtnWidget(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialogWidget(
                                title: 'Update Category',
                                hintText: 'Enter name',
                                controller: typeController,
                                onPressed: () {
                                  final createCategoryCubit = context.read<UpdateCategoryCubit>();
                                  createCategoryCubit.fetchUpdateCategory(name: typeController.text, id: allCategoryModel.id);
                                  Navigator.pop(context);
                                },
                              );
                            },
                          );
                        },
                        icon: Icons.edit,
                        color: ColorManager.blue2,
                      ),
                    ),
                    IconBtnWidget(
                      onPressed: ()
                      {
                        DeleteCategoryCubit.get(context).fetchDeleteCategory(id: allCategoryModel.id);
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
                    allCategoryModel.name,
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
  }
}
