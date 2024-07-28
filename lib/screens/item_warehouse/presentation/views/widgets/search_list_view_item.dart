import 'package:flutter/material.dart';
import 'package:project2/screens/item_warehouse/data/models/all_items_model.dart';

import '../../../../../core/utils/app_manager.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/style_manager.dart';
import '../../../../../widgets/icon_btn_widget.dart';
import '../../../data/models/search_items_model.dart';
import '../../manager/delete_item_cubit/delete_item_cubit.dart';
import '../update_item_view.dart';

class SearchListViewItem extends StatelessWidget {
  const SearchListViewItem({Key? key, required this.rank, required this.allSearchItems}) : super(key: key);

  final DataSearch allSearchItems;
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
                  allSearchItems.name,
                  style: StyleManager.body1Regular(color: ColorManager.blackColor),
                ),
              ),
              const Spacer(),
              Text(
                allSearchItems.quantity.toString(),
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
                      allItems: allSearchItems as DataView,
                    ),),
                  );
                },
                icon: Icons.edit,
                color: ColorManager.blue2,
              ),
              IconBtnWidget(
                onPressed: ()
                {
                  DeleteItemCubit.get(context).fetchDeleteItem(id: allSearchItems.id);
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
