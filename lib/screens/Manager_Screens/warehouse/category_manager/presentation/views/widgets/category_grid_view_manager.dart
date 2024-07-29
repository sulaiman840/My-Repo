import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../warehouse_home/category_warehouse/presentation/manager/delete_category_cubit/delete_category_cubit.dart';
import '../../../../../../warehouse_home/category_warehouse/presentation/manager/delete_category_cubit/delete_category_state.dart';
import '../../../../../../warehouse_home/category_warehouse/presentation/manager/get_all_category_cubit/get_all_category_cubit.dart';
import '../../../../../../warehouse_home/category_warehouse/presentation/manager/get_all_category_cubit/get_all_category_state.dart';
import '../../../../item_manager/presentation/views/all_item_view_manager.dart';
import 'category_grid_view_item_manager.dart';

class CategoryGridViewManager extends StatelessWidget {
  const CategoryGridViewManager({Key? key, required this.typeId}) : super(key: key);

  final int typeId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetAllCategoryCubit, GetAllCategoryState>(
      listener: (context, state) {
        if (state is DeleteCategorySuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Type deleted successfully")),
          );
        } else if (state is DeleteCategoryFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Type deleted failed")),
          );
        }
      },
      builder: (BuildContext context, state) {
        if (state is GetAllCategorySuccess) {
          return BlocConsumer<DeleteCategoryCubit, DeleteCategoryState>(
            listener: (contextDelete, stateDelete) {
              if (stateDelete is DeleteCategorySuccess) {
                ScaffoldMessenger.of(contextDelete).showSnackBar(
                  const SnackBar(content: Text("Category deleted successfully")),
                );
              } else if (stateDelete is DeleteCategoryFailure) {
                ScaffoldMessenger.of(contextDelete).showSnackBar(
                  const SnackBar(content: Text("Category deleted failed")),
                );
              }
            },
            builder: (contextDelete, stateDelete) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.allCategories.length,
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:6,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 6,
                ),
                itemBuilder: (context,index)=> CategoryGridViewItemManager(
                  allCategoryModel: state.allCategories[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_)=> AllItemViewManager(
                          typeId: typeId,
                          categoryId: state.allCategories[index].id,
                        ),
                      ),
                    );
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
  }
}
