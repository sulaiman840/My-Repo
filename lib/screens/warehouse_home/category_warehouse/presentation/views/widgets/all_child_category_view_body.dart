import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_manager.dart';
import '../../../../../../core/utils/service_locator.dart';
import '../../../data/models/get_all_category_model.dart';
import '../../../data/repos/category_repo_impl.dart';
import '../../manager/delete_category_cubit/delete_category_cubit.dart';
import 'child_category_grid_view.dart';

class AllChildCategoryViewBody extends StatelessWidget {
  AllChildCategoryViewBody({Key? key, required this.typeId, required this.childCategory}) : super(key: key);

  final TextEditingController categoryController = TextEditingController();
  final int typeId;
  final List<GetAllCategoryModel> childCategory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: AppPadding.p16,
        bottom: AppPadding.p16,
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
              height: AppSize.s20,
            ),
            BlocProvider(
                create: (context) {
                  return DeleteCategoryCubit(
                    getIt.get<CategoryRepoImpl>(),
                  );
                },
                child: ChildCategoryGridView(typeId: typeId, childCategory: childCategory,)),
          ],
        ),
      ),
    );
  }
}
