import 'package:flutter/material.dart';

import '../../../../../core/utils/app_manager.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/style_manager.dart';
import '../../../../item_warehouse/data/models/all_items_model.dart';

class ItemListViewItemManager extends StatelessWidget {
  const ItemListViewItemManager({Key? key, required this.allItems, required this.rank}) : super(key: key);

  final DataView allItems;
  final int rank;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints.tightFor(
            width: MediaQuery.of(context).size.width / 1,
            height: 70.0,
          ),
          padding:const EdgeInsetsDirectional.symmetric(
            vertical: AppPadding.p16,
            horizontal: AppPadding.p16,
          ),
          decoration: BoxDecoration(
            color: ColorManager.bc2,
            borderRadius: BorderRadius.circular(AppSize.s12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                rank.toString(),
                style: StyleManager.body1Regular(),
              ),
              const SizedBox(width: AppSize.s50,),
              Center(
                child: Text(
                  allItems.name,
                  style: StyleManager.body1Regular(color: ColorManager.blackColor),
                ),
              ),
              const Spacer(),
              Text(
                allItems.quantity.toString(),
                style: StyleManager.body1Regular(color: ColorManager.blackColor),
              ),
              const SizedBox(width: AppSize.s50,),
              const Spacer(),
            ],
          ),
        )
      ],
    );
  }
}
