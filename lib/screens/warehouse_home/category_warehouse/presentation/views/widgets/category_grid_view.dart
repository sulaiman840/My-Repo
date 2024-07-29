import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../item_warehouse/presentation/views/all_items_view.dart';
import '../../manager/delete_category_cubit/delete_category_cubit.dart';
import '../../manager/delete_category_cubit/delete_category_state.dart';
import '../../manager/get_all_category_cubit/get_all_category_cubit.dart';
import '../../manager/get_all_category_cubit/get_all_category_state.dart';
import '../../manager/update_category_cubit/update_category_cubit.dart';
import '../../manager/update_category_cubit/update_category_state.dart';
import 'category_grid_view_item.dart';

class CategoryGridView extends StatelessWidget {
  const CategoryGridView({Key? key, required this.typeId}) : super(key: key);

  final int typeId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllCategoryCubit, GetAllCategoryState>(
      builder: (context, state) {
        return BlocConsumer<UpdateCategoryCubit, UpdateCategoryState>(
          listener: (contextUpdate, stateUpdate) {
            if (stateUpdate is UpdateCategorySuccess) {
              ScaffoldMessenger.of(contextUpdate).showSnackBar(
                const SnackBar(content: Text("Category Updated successfully")),
              );
            } else if (stateUpdate is UpdateCategoryFailure) {
              ScaffoldMessenger.of(contextUpdate).showSnackBar(
                const SnackBar(content: Text("Category Updated failed")),
              );
            }
          },
          builder: (contextUpdate, stateUpdate) {
            if (state is GetAllCategorySuccess) {
              return BlocConsumer<DeleteCategoryCubit, DeleteCategoryState>(
                listener: (contextDelete, stateDelete) {
                  if (stateDelete is DeleteCategorySuccess) {
                    contextDelete.read<GetAllCategoryCubit>().fetchAllCategories();
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
                    itemBuilder: (context,index)=> CategoryGridViewItem(
                      allCategoryModel: state.allCategories[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_)=> AllItemsView(
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
      },
    );
  }
}
