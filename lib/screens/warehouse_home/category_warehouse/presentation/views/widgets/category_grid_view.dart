import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../widgets/custom_snack_bar.dart';
import '../../../../item_warehouse/presentation/views/all_items_view.dart';
import '../../manager/delete_category_cubit/delete_category_cubit.dart';
import '../../manager/delete_category_cubit/delete_category_state.dart';
import '../../manager/get_all_category_cubit/get_all_category_cubit.dart';
import '../../manager/get_all_category_cubit/get_all_category_state.dart';
import '../../manager/update_category_cubit/update_category_cubit.dart';
import '../../manager/update_category_cubit/update_category_state.dart';
import '../all_child_category_view.dart';
import 'category_grid_view_item.dart';
import '../../../data/models/get_all_category_model.dart';

class CategoryGridView extends StatelessWidget {
  CategoryGridView({Key? key, required this.typeId}) : super(key: key);

  final int typeId;
  List<GetAllCategoryModel> parentCategory = [];
  List<GetAllCategoryModel>? allChildCategory = [];
  List<GetAllCategoryModel>? childCategory = [];

  @override
  Widget build(BuildContext context) {
    parentCategory.clear();
    allChildCategory!.clear();
    childCategory!.clear();
    return BlocBuilder<GetAllCategoryCubit, GetAllCategoryState>(
      builder: (context, state) {
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
            parentCategory.clear();
            allChildCategory!.clear();
            childCategory!.clear();
            if (state is GetAllCategorySuccess) {
              return BlocConsumer<DeleteCategoryCubit, DeleteCategoryState>(
                listener: (contextDelete, stateDelete) {
                  if (stateDelete is DeleteCategorySuccess) {
                    parentCategory.clear();
                    allChildCategory!.clear();
                    childCategory!.clear();
                    contextDelete.read<GetAllCategoryCubit>().fetchAllCategories();
                    CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('category_deleted_successfully'),);
                    /*ScaffoldMessenger.of(contextDelete).showSnackBar(
                      SnackBar(content: Text(AppLocalizations.of(context).translate('category_deleted_successfully'))),
                    );*/
                  } else if (stateDelete is DeleteCategoryFailure) {
                    parentCategory.clear();
                    allChildCategory!.clear();
                    childCategory!.clear();
                    CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('category_deleted_failed'),);
                    /*ScaffoldMessenger.of(contextDelete).showSnackBar(
                      SnackBar(content: Text(AppLocalizations.of(context).translate('category_deleted_failed'))),
                    );*/
                  }
                },
                builder: (contextDelete, stateDelete) {
                  parentCategory.clear();
                  allChildCategory!.clear();
                  childCategory!.clear();
                  for(int i = 0; i < state.allCategories.length; i++)
                  {
                    state.allCategories[i].parentId != null ? allChildCategory!.add(state.allCategories[i]) : parentCategory.add(state.allCategories[i]);
                  }
                  log('parentCategory ${parentCategory.toString()}');
                  log('childCategory ${allChildCategory.toString()}');
                  return parentCategory.isEmpty ? Center(child: Center(child: Text(AppLocalizations.of(context).translate('empty_list_message')),),)
                      : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: parentCategory.length,
                    gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:6,
                      crossAxisSpacing: 18,
                      mainAxisSpacing: 6,
                    ),
                    itemBuilder: (context,index)=> CategoryGridViewItem(
                      allCategoryModel: parentCategory[index],
                      onTap: () {
                        childCategory!.clear();
                        for(int i = 0; i < allChildCategory!.length; i++)
                        {
                          if(parentCategory[index].id == allChildCategory![i].parentId) {
                            childCategory!.add(allChildCategory![i]);
                          }
                        }
                        int categoryId = parentCategory[index].id;
                        childCategory!.length == 0 ? context.go('/AllItemsView/$typeId/$categoryId')/*Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_)=> AllItemsView(
                              typeId: typeId,
                              categoryId: parentCategory[index].id,
                            ),
                          ),
                        )*/
                            : context.go('/AllChildCategoryView/$typeId', extra: childCategory);/*Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_)=> AllChildCategoryView(typeId: typeId, childCategory: childCategory!,),
                          ),
                        )*/;
                      },
                    ),
                  );
                },
              );
            } else if (state is GetAllCategoryFailure) {
              return Text(state.errorMessage);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
  }
}
