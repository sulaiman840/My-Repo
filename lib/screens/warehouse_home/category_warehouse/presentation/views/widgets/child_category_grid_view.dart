import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../widgets/custom_snack_bar.dart';
import '../../../../item_warehouse/presentation/views/all_items_view.dart';
import '../../../data/models/get_all_category_model.dart';
import '../../manager/delete_category_cubit/delete_category_cubit.dart';
import '../../manager/delete_category_cubit/delete_category_state.dart';
import '../../manager/get_all_category_cubit/get_all_category_cubit.dart';
import '../../manager/get_all_category_cubit/get_all_category_state.dart';
import '../../manager/update_category_cubit/update_category_cubit.dart';
import '../../manager/update_category_cubit/update_category_state.dart';
import 'child_category_grid_view_item.dart';

class ChildCategoryGridView extends StatelessWidget {
  const ChildCategoryGridView({Key? key, required this.typeId, required this.childCategory}) : super(key: key);

  final int typeId;
  final List<GetAllCategoryModel> childCategory;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateCategoryCubit, UpdateCategoryState>(
      listener: (contextUpdate, stateUpdate) {
        if (stateUpdate is UpdateCategorySuccess) {
          CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('category_updated_successfully'),);
          /*ScaffoldMessenger.of(contextUpdate).showSnackBar(
                SnackBar(content: Text(AppLocalizations.of(context).translate('category_updated_successfully'))),
              );*/
        } else if (stateUpdate is UpdateCategoryFailure) {
          CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('category_updated_failed'),);
          /*ScaffoldMessenger.of(contextUpdate).showSnackBar(
                SnackBar(content: Text(AppLocalizations.of(context).translate('category_updated_failed'))),
              );*/
        }
      },
      builder: (contextUpdate, stateUpdate) {
        return BlocConsumer<DeleteCategoryCubit, DeleteCategoryState>(
          listener: (contextDelete, stateDelete) {
            if (stateDelete is DeleteCategorySuccess) {
              contextDelete.read<GetAllCategoryCubit>().fetchAllCategories();
              CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('category_deleted_successfully'),);
              /*ScaffoldMessenger.of(contextDelete).showSnackBar(
                      SnackBar(content: Text(AppLocalizations.of(context).translate('category_deleted_successfully'))),
                    );*/
            } else if (stateDelete is DeleteCategoryFailure) {
              CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('category_deleted_failed'),);
              /*ScaffoldMessenger.of(contextDelete).showSnackBar(
                      SnackBar(content: Text(AppLocalizations.of(context).translate('category_deleted_failed'))),
                    );*/
            }
          },
          builder: (contextDelete, stateDelete) {
            return childCategory.isEmpty ? Center(child: Center(child: Text(AppLocalizations.of(context).translate('empty_list_message')),),)
                : GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: childCategory.length,
              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:6,
                crossAxisSpacing: 18,
                mainAxisSpacing: 6,
              ),
              itemBuilder: (context,index)=> ChildCategoryGridViewItem(
                allCategoryModel: childCategory[index],
                onTap: () {
                  int categoryId = childCategory[index].id;
                  context.go('/AllItemsView/$typeId/$categoryId');
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_)=> AllItemsView(
                        typeId: typeId,
                        categoryId: childCategory[index].id,
                      ),
                    ),
                  );*/
                },
              ),
            );
          },
        );
      },
    );
  }
}
