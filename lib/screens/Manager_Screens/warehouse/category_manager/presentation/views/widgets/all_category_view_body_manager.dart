import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/utils/app_manager.dart';
import '../../../../../../../core/utils/color_manager.dart';
import '../../../../../../../core/utils/service_locator.dart';
import '../../../../../../../core/utils/style_manager.dart';

import '../../../../../../warehouse_home/category_warehouse/data/repos/category_repo_impl.dart';
import '../../../../../../warehouse_home/category_warehouse/presentation/manager/delete_category_cubit/delete_category_cubit.dart';
import '../../../../../../warehouse_home/category_warehouse/presentation/manager/get_all_category_cubit/get_all_category_cubit.dart';
import '../../../../../../warehouse_home/category_warehouse/presentation/manager/get_all_category_cubit/get_all_category_state.dart';
import 'category_grid_view_manager.dart';

class AllCategoryViewBodyManager extends StatelessWidget {
  AllCategoryViewBodyManager({Key? key, required this.typeId}) : super(key: key);

  final TextEditingController categoryController = TextEditingController();
  final int typeId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetAllCategoryCubit, GetAllCategoryState>(
      listener: (context, state) {
        /*if (state is GetAllCategorySuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Category created successfully")),
          );
        } else if (state is GetAllCategoryFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Category created failed")),
          );
        }*/
      },
      builder: (context, state) {
        if (state is GetAllCategorySuccess) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(
              top: AppPadding.p16,
              start: AppPadding.p16,
              end: AppPadding.p16,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: AppSize.s24,
                  ),
                  BlocProvider(
                      create: (context) {
                        return DeleteCategoryCubit(
                          getIt.get<CategoryRepoImpl>(),
                        );
                      },
                      child: CategoryGridViewManager(typeId: typeId,)),
                ],
              ),
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
