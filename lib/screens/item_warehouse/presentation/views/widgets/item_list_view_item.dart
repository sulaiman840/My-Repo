import 'package:flutter/material.dart';

import '../../../../../../../core/utils/app_manager.dart';
import '../../../../../../../core/utils/color_manager.dart';
import '../../../../../../../core/utils/style_manager.dart';
import '../../../../../../../widgets/icon_btn_widget.dart';
import '../../../data/models/all_items_model.dart';
import '../../manager/delete_item_cubit/delete_item_cubit.dart';
import '../update_item_view.dart';

class ItemListViewItem extends StatelessWidget {
  const ItemListViewItem({Key? key, required this.allItems, required this.rank}) : super(key: key);

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
            height: 80.0,
          ),
          padding:const EdgeInsetsDirectional.symmetric(
            vertical: AppPadding.p16,
            horizontal: AppPadding.p16,
          ),
          decoration: BoxDecoration(
            color: ColorManager.bc1,
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
              IconBtnWidget(
                onPressed: ()
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UpdateItemView(
                        allItems: allItems,
                      ),),
                  );
                },
                icon: Icons.edit,
                color: ColorManager.blue2,
              ),
              IconBtnWidget(
                onPressed: ()
                {
                  DeleteItemCubit.get(context).fetchDeleteItem(id: allItems.id);
                },
                icon: Icons.delete,
                color: ColorManager.orange,
              ),
              const SizedBox(height: AppSize.s20,),
            ],
          ),
        )
      ],
    );
  }
}
