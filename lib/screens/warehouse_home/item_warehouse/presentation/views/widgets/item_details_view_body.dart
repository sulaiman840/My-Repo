import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_manager.dart';
import '../../../../../../core/utils/color_manager.dart';
import '../../../../../../widgets/icon_btn_widget.dart';
import '../../../../widget/custom_dialog_widget.dart';
import '../../manager/consume_item_cubit/consume_item_cubit.dart';
import '../../manager/item_by_id_cubit/item_by_id_cubit.dart';
import '../../manager/item_by_id_cubit/item_by_id_state.dart';

class ItemDetailsViewBody extends StatelessWidget {
  ItemDetailsViewBody({Key? key}) : super(key: key);

  final TextEditingController increaseQuantityController = TextEditingController();
  final TextEditingController decreaseQuantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItemByIdCubit, ItemByIdState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        if(state is ItemByIdSuccess) {
          return Padding(
            padding: const EdgeInsets.all(AppSize.s16),
            child: SingleChildScrollView(
              child: Material(
                borderRadius: const BorderRadiusDirectional.all(Radius.circular(10.0)),
                color: Colors.grey.shade100,
                elevation: 2.0,
                child: SizedBox(
                  height: 400.0,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSize.s16),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.feed,
                              color: ColorManager.blue,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppSize.s16,),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context).translate('category_name'),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    state.item.name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        state.item.expiredDate != null ? const Spacer() : const SizedBox(height: 0, width: 0,),
                        state.item.expiredDate != null ? Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.calendar_today_outlined,
                              color: ColorManager.blue,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppSize.s16,),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context).translate('expired_date'),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    state.item.expiredDate!,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ) : const SizedBox(height: 0, width: 0,),
                        const Spacer(),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.shopping_bag_outlined,
                              color: ColorManager.blue,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppSize.s16,),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context).translate('quantity'),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        state.item.quantity.toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  /*IconBtnWidget(
                                    onPressed: ()
                                    {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CustomDialogWidget(
                                            title: '${state.item.quantity}',
                                            hintText: 'Enter quantity',
                                            controller: increaseQuantityController,
                                            validator: (value) {
                                              if (value?.isEmpty ?? true) {
                                                return 'this field must not be empty';
                                              } else {
                                                if (state.item.quantity > int.parse(increaseQuantityController.text)) {
                                                  return 'Quantity must be increase';
                                                }
                                              }
                                              return null;
                                            },
                                            onPressed: () {
                                              UpdateItemCubit.get(context).fetchUpdateItem(
                                                id: state.item.id,
                                                name: state.item.name,
                                                typeId: state.item.typeId,
                                                categoryId: state.item.categoryId,
                                                description: state.item.description,
                                                expiredDate: state.item.expiredDate,
                                                quantity: int.parse(increaseQuantityController.text),
                                              );
                                              Navigator.pop(context);
                                              ItemByIdCubit.get(context).fetchItemById(id: state.item.id);
                                            },
                                          );
                                        },
                                      );
                                    },
                                    icon: Icons.add,
                                    color: ColorManager.blue2,
                                  ),*/
                                  /*IconBtnWidget(
                                    onPressed: ()
                                    {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CustomDialogFieldWidget(
                                            title: '${state.item.quantity}',
                                            hintText: 'Enter quantity',
                                            controller: decreaseQuantityController,
                                            validator: (value) {
                                              if (value?.isEmpty ?? true) {
                                                return 'this field must not be empty';
                                              } else {
                                                if (state.item.quantity < int.parse(decreaseQuantityController.text)) {
                                                  return 'Quantity must be decrease';
                                                }
                                              }
                                              return null;
                                            },
                                            onPressed: () {
                                              ConsumeItemCubit.get(context).fetchConsumeItem(
                                                id: state.item.id,
                                                quantityConsume: int.parse(decreaseQuantityController.text),
                                              );
                                              Navigator.pop(context);
                                              ItemByIdCubit.get(context).fetchItemById(id: state.item.id);
                                            },
                                          );
                                        },
                                      );
                                    },
                                    icon: Icons.minimize,
                                    color: ColorManager.blue2,
                                  ),*/
                                ],
                              ),
                            ),
                          ],
                        ),
                        state.item.expiredDate != null ? const Spacer() : const SizedBox(height: 0, width: 0,),
                        state.item.expiredDate != null ? Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.warning_amber,
                              color: ColorManager.blue,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppSize.s16,),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context).translate('minimum_quantity'),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    state.item.minimumQuantity.toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ) : const SizedBox(height: 0, width: 0,),
                        const Spacer(),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.description,
                              color: ColorManager.blue,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppSize.s16,),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context).translate('description'),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    state.item.description,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.watch_later_outlined,
                              color: ColorManager.blue,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppSize.s16,),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context).translate('request_status'),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    state.item.status.toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if(state is ItemByIdFailure) {
          return Text(state.errorMessage);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
