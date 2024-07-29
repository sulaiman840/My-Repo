import 'package:flutter/material.dart';

import '../../../../../../../core/utils/app_manager.dart';
import '../../../../../../../core/utils/color_manager.dart';
import '../../../../../../../core/utils/style_manager.dart';
import '../../../../../../warehouse_home/type_warehouse/data/models/get_all_type_model.dart';

class TypeGridViewItemManager extends StatelessWidget {
  const TypeGridViewItemManager({super.key, required this.onTap, required this.allTypeModel});

  final GetAllTypeModel allTypeModel;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
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
                allTypeModel.name,
                style: StyleManager.body1SemiBold(color: ColorManager.blackColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
