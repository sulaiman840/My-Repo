import 'package:flutter/material.dart';

import '../../../../../../../core/utils/app_manager.dart';
import '../../../../../../../core/utils/color_manager.dart';
import '../../../../../../../core/utils/style_manager.dart';
import '../../../../../../warehouse_home/item_warehouse/data/models/search_items_model.dart';

class SearchListViewItemManager extends StatelessWidget {
  SearchListViewItemManager({Key? key, required this.rank, required this.allSearchItems}) : super(key: key);

  final DataSearch allSearchItems;
  final int rank;
  DateTime today = DateTime.now();
  DateTime? inputDate;
  DateTime? todayOnlyDate;
  DateTime? inputOnlyDate;
  DateTime? oneWeekLater;

  @override
  Widget build(BuildContext context) {
    if(allSearchItems.expiredDate != null) {
      inputDate = DateTime.parse(allSearchItems.expiredDate!);
      todayOnlyDate = DateTime(today.year, today.month, today.day);
      inputOnlyDate = DateTime(inputDate!.year, inputDate!.month, inputDate!.day);
      oneWeekLater = todayOnlyDate!.add(Duration(days: 7));
    }
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
                  allSearchItems.name,
                  style: StyleManager.body1Regular(
                    color: allSearchItems.expiredDate == null ? ColorManager.blackColor
                        : inputOnlyDate!.isBefore(todayOnlyDate!) ? Colors.red
                        : inputOnlyDate!.isAfter(oneWeekLater!) ? Colors.green
                        : inputOnlyDate!.isAtSameMomentAs(todayOnlyDate!) ? Colors.orange
                        : inputOnlyDate!.isAfter(todayOnlyDate!) ? Colors.orange
                        : ColorManager.blackColor,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                allSearchItems.quantity.toString(),
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
