import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/utils/app_manager.dart';
import '../../../../../../warehouse_home/category_warehouse/data/models/get_all_category_model.dart';
import 'child_category_grid_view_m.dart';

class AllChildCategoryViewBodyM extends StatelessWidget {
  AllChildCategoryViewBodyM({Key? key, required this.typeId, required this.childCategory}) : super(key: key);

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
            ChildCategoryGridViewM(typeId: typeId, childCategory: childCategory,),
          ],
        ),
      ),
    );
  }
}
