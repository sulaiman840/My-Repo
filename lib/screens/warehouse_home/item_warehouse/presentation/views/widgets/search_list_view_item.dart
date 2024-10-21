import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_manager.dart';
import '../../../../../../core/utils/color_manager.dart';
import '../../../../../../core/utils/style_manager.dart';
import '../../../../../../widgets/icon_btn_widget.dart';
import '../../../../widget/custom_dialog_widget.dart';
import '../../../data/models/all_items_model.dart';
import '../../../data/models/search_items_model.dart';
import '../../manager/consume_item_cubit/consume_item_cubit.dart';
import '../../manager/delete_item_cubit/delete_item_cubit.dart';
import '../update_item_view.dart';

class SearchListViewItem extends StatelessWidget {
  SearchListViewItem({Key? key, required this.rank, required this.allSearchItems}) : super(key: key);

  final DataSearch allSearchItems;
  final int rank;
  final TextEditingController decreaseQuantityController = TextEditingController();
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
              Tooltip(
                message: AppLocalizations.of(context).translate('withdraw'),
                child: IconBtnWidget(
                  onPressed: ()
                  {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialogFieldWidget(
                          title: AppLocalizations.of(context).translate('withdraw_items'),
                          hintText: AppLocalizations.of(context).translate('enter_quantity'),
                          controller: decreaseQuantityController,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return AppLocalizations.of(context).translate('validate_field_empty');
                            } else {
                              if (allSearchItems.quantity < int.parse(decreaseQuantityController.text)) {
                                return AppLocalizations.of(context).translate('validate_quantity');
                              }
                            }
                            return null;
                          },
                          onPressed: () {
                            ConsumeItemCubit.get(context).fetchConsumeItem(
                              id: allSearchItems.id,
                              quantityConsume: int.parse(decreaseQuantityController.text),
                            );
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  },
                  icon: Icons.output_outlined,
                  color: ColorManager.blue2,
                ),
              ),
              Tooltip(
                message: AppLocalizations.of(context).translate('update'),
                child: IconBtnWidget(
                  onPressed: ()
                  {
                    context.pushReplacement('/UpdateSearchItemView', extra: allSearchItems);
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UpdateItemView(
                        allItems: allSearchItems as DataView,
                      ),),
                    );*/
                  },
                  icon: Icons.edit,
                  color: ColorManager.blue2,
                ),
              ),
              Tooltip(
                message: AppLocalizations.of(context).translate('delete'),
                child: IconBtnWidget(
                  onPressed: ()
                  {
                    showDialog(
                      context: context,
                      builder: (BuildContext contextD) {
                        return AlertDialog(
                          content: Text(AppLocalizations.of(context).translate('make_sure_delete')),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(AppLocalizations.of(context).translate('cancel')),
                            ),
                            TextButton(
                              onPressed: () {
                                DeleteItemCubit.get(context).fetchDeleteItem(id: allSearchItems.id);
                                Navigator.of(context).pop();
                              },
                              child: Text(AppLocalizations.of(context).translate('delete')),
                            ),
                          ],
                        );
                      },
                    );
                    //DeleteItemCubit.get(context).fetchDeleteItem(id: allSearchItems.id);
                  },
                  icon: Icons.delete,
                  color: ColorManager.orange,
                ),
              ),
              const SizedBox(height: AppSize.s20,),
            ],
          ),
        )
      ],
    );
  }
}
