import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/utils/app_manager.dart';
import '../../../../../../../core/utils/color_manager.dart';
import '../../../../../../../core/utils/service_locator.dart';
import '../../../../../../../core/utils/style_manager.dart';
import '../../../../../warehouse_home/widget/circular_icon_widget.dart';
import '../../../../../warehouse_home/widget/custom_dialog_widget.dart';
import '../../../../../warehouse_home/widget/elevated_btn_widget.dart';
import '../../../data/repos/category_repo_impl.dart';
import '../../manager/create_category_cubit/create_category_cubit.dart';
import '../../manager/create_category_cubit/create_category_state.dart';
import '../../manager/delete_category_cubit/delete_category_cubit.dart';
import 'category_grid_view.dart';

class AllCategoryViewBody extends StatelessWidget {
  AllCategoryViewBody({Key? key, required this.typeId}) : super(key: key);

  final TextEditingController categoryController = TextEditingController();
  final int typeId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateCategoryCubit, CreateCategoryState>(
      listener: (context, state) {
        if (state is CreateCategoryFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Category created failed")),
          );
        } else if (state is CreateCategorySuccess) {
          //context.read<GetAllCategoryCubit>().fetchAllCategories();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Category created successfully')),
          );
        }
      },
      builder: (context, state) {
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
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: elevatedbtn(
                    icon: circleIconWidget(
                      icon: Icons.add,
                      backgroundColor: ColorManager.orange,
                      color: ColorManager.bc0,
                    ),
                    text: 'Add New Category',
                    style: StyleManager.labelMedium(color: ColorManager.bc4),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialogWidget(
                            title: 'Add new Category',
                            hintText: 'Enter name',
                            controller: categoryController,
                            onPressed: () {
                              final createCategoryCubit =
                              context.read<CreateCategoryCubit>();
                              createCategoryCubit.fetchCreateCategory(
                                  name: categoryController.text, parentId: 1);
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Text(
                  'Types',
                  style: StyleManager.h3Bold(color: ColorManager.blackColor),
                ),
                const SizedBox(
                  height: AppSize.s24,
                ),
                BlocProvider(
                    create: (context) {
                      return DeleteCategoryCubit(
                        getIt.get<CategoryRepoImpl>(),
                      );
                    },
                    child: CategoryGridView(typeId: typeId,)),
              ],
            ),
          ),
        );
      },
    );
  }
}
