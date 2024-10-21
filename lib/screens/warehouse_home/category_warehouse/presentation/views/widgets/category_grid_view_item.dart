import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/utils/app_manager.dart';
import '../../../../../../../core/utils/color_manager.dart';
import '../../../../../../../core/utils/service_locator.dart';
import '../../../../../../../core/utils/style_manager.dart';
import '../../../../../../../widgets/icon_btn_widget.dart';
import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../widgets/custom_snack_bar.dart';
import '../../../../../warehouse_home/widget/custom_dialog_widget.dart';
import '../../../data/models/get_all_category_model.dart';
import '../../../data/repos/category_repo_impl.dart';
import '../../manager/create_category_cubit/create_category_cubit.dart';
import '../../manager/delete_category_cubit/delete_category_cubit.dart';
import '../../manager/delete_category_cubit/delete_category_state.dart';
import '../../manager/get_all_category_cubit/get_all_category_cubit.dart';
import '../../manager/update_category_cubit/update_category_cubit.dart';

class CategoryGridViewItem extends StatelessWidget {
  CategoryGridViewItem({super.key, required this.onTap, required this.allCategoryModel});

  final GetAllCategoryModel allCategoryModel;
  final Function()? onTap;
  final TextEditingController typeController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteCategoryCubit, DeleteCategoryState>(
      listener: (context, state) {
        if (state is DeleteCategorySuccess) {
          context.read<GetAllCategoryCubit>().fetchAllCategories();
          CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('category_deleted_successfully'),);
          /*ScaffoldMessenger.of(contextDelete).showSnackBar(
                      SnackBar(content: Text(AppLocalizations.of(context).translate('category_deleted_successfully'))),
                    );*/
        } else if (state is DeleteCategoryFailure) {
          CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('category_deleted_failed'),);
          /*ScaffoldMessenger.of(contextDelete).showSnackBar(
                      SnackBar(content: Text(AppLocalizations.of(context).translate('category_deleted_failed'))),
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
                  width: 250.0,
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
                        IconBtnWidget(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogFieldWidget(
                                  title: AppLocalizations.of(context).translate('add_new_category'),
                                  hintText: AppLocalizations.of(context).translate('enter_name'),
                                  controller: categoryController,
                                  onPressed: () {
                                    final createCategoryCubit =
                                    context.read<CreateCategoryCubit>();
                                    createCategoryCubit.fetchCreateCategory(
                                        name: categoryController.text, parentId: allCategoryModel.id);
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
                          },
                          icon: Icons.add,
                          color: ColorManager.blue2,
                        ),
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
                                  return CustomDialogFieldWidget(
                                    title: AppLocalizations.of(context).translate('update_category'),
                                    hintText: AppLocalizations.of(context).translate('enter_name'),
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
                                        context.read<DeleteCategoryCubit>().fetchDeleteCategory(id: allCategoryModel.id);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(AppLocalizations.of(context).translate('delete')),
                                    ),
                                  ],
                                );
                              },
                            );
                            //DeleteCategoryCubit.get(context).fetchDeleteCategory(id: allCategoryModel.id);
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
      },
    );
  }
}
