import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/localization/app_localizations.dart';
import '../../../../../../warehouse_home/category_warehouse/data/models/get_all_category_model.dart';
import '../../../../../../warehouse_home/category_warehouse/presentation/manager/get_all_category_cubit/get_all_category_cubit.dart';
import '../../../../../../warehouse_home/category_warehouse/presentation/manager/get_all_category_cubit/get_all_category_state.dart';
import '../../../../item_manager/presentation/views/all_item_view_manager.dart';
import '../all_child_category_view_m.dart';
import 'category_grid_view_item_manager.dart';

class CategoryGridViewManager extends StatelessWidget {
  CategoryGridViewManager({Key? key, required this.typeId}) : super(key: key);

  final int typeId;
  List<GetAllCategoryModel> parentCategory = [];
  List<GetAllCategoryModel>? allChildCategory = [];
  List<GetAllCategoryModel>? childCategory = [];

  @override
  Widget build(BuildContext context) {
    parentCategory.clear();
    allChildCategory!.clear();
    childCategory!.clear();
    return BlocConsumer<GetAllCategoryCubit, GetAllCategoryState>(
      listener: (context, state) {  },
      builder: (BuildContext context, state) {
        if (state is GetAllCategorySuccess) {
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
            itemBuilder: (context,index)=> CategoryGridViewItemManager(
              allCategoryModel: parentCategory[index],
              onTap: () {
                childCategory!.clear();
                for(int i = 0; i < allChildCategory!.length; i++)
                {
                  if(parentCategory[index].id == allChildCategory![i].parentId) {
                    childCategory!.add(allChildCategory![i]);
                  }
                }
                int categoryId = state.allCategories[index].id;
                childCategory!.length == 0 ? context.go('/AllItemViewManager/$typeId/$categoryId')/*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_)=> AllItemViewManager(
                      typeId: typeId,
                      categoryId: state.allCategories[index].id,
                    ),
                  ),
                )*/
                    : context.go('/AllChildCategoryViewM/$typeId', extra: childCategory);/*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_)=> AllChildCategoryViewM(typeId: typeId, childCategory: childCategory!,),
                  ),
                );*/
              },
            ),
          );
        } else if (state is GetAllCategoryFailure) {
          return Text(state.errorMessage);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
