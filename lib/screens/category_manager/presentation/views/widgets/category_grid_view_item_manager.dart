import 'package:flutter/material.dart';

import '../../../../../core/utils/app_manager.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/style_manager.dart';
import '../../../../category_warehouse/data/models/get_all_category_model.dart';

class CategoryGridViewItemManager extends StatelessWidget {
  CategoryGridViewItemManager({super.key, required this.onTap, required this.allCategoryModel});

  final GetAllCategoryModel allCategoryModel;
  final Function()? onTap;
  final TextEditingController typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints.tightFor(
              width: MediaQuery.of(context).size.width/6,
              height: 150.0,
            ),
            padding:const EdgeInsetsDirectional.symmetric(
              vertical: AppPadding.p16,
              horizontal: AppPadding.p16,
            ),
            decoration: BoxDecoration(
              color: ColorManager.bc2,
              borderRadius: BorderRadius.circular(AppSize.s12),
            ),
            child: Center(
              child: Text(
                allCategoryModel.name,
                style: StyleManager.body1SemiBold(color: ColorManager.blackColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
