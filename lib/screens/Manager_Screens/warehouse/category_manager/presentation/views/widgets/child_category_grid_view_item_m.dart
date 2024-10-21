import 'package:flutter/material.dart';

import '../../../../../../../core/utils/app_manager.dart';
import '../../../../../../../core/utils/color_manager.dart';
import '../../../../../../../core/utils/style_manager.dart';
import '../../../../../../warehouse_home/category_warehouse/data/models/get_all_category_model.dart';

class ChildCategoryGridViewItemM extends StatelessWidget {
  ChildCategoryGridViewItemM({Key? key, required this.allCategoryModel, this.onTap}) : super(key: key);

  final GetAllCategoryModel allCategoryModel;
  final Function()? onTap;
  final TextEditingController typeController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();


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
              height: 165.0,
            ),
            padding:const EdgeInsetsDirectional.symmetric(
              vertical: AppPadding.p16,
              horizontal: AppPadding.p16,
            ),
            decoration: BoxDecoration(
              color: ColorManager.bc2,
              borderRadius: BorderRadius.circular(AppSize.s12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: AppSize.s20,),
                //name
                Center(
                  child: Text(
                    allCategoryModel.name,
                    style: StyleManager.body1SemiBold(color: ColorManager.blackColor),
                  ),
                ),
                const SizedBox(height: AppSize.s50,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
