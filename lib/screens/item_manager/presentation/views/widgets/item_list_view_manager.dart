import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_manager.dart';
import '../../../../item_warehouse/presentation/manager/get_all_items_cubit/get_all_items_cubit.dart';
import '../../../../item_warehouse/presentation/manager/get_all_items_cubit/get_all_items_state.dart';
import 'item_list_view_item_manager.dart';

class ItemListViewManager extends StatelessWidget {
  const ItemListViewManager({Key? key}) : super(key: key);

  final int paginate = 50;

  @override
  Widget build(BuildContext context) {
    GetAllItemsCubit cubit = GetAllItemsCubit.get(context);
    log("initial**********************************************************************************************${cubit.afterIncreasePaginate}");
    return BlocBuilder<GetAllItemsCubit, GetAllItemsState>(
        builder: (context, state) {
          if(state is GetAllItemsSuccess) {
            log("initial111111**********************************************************************************************${cubit.afterIncreasePaginate}");
            return Column(
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.allItems.dataView.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StaffDetailsView(id: state.allStaff[index].id),),
                );*/
                    },
                    child: ItemListViewItemManager(
                      allItems: state.allItems.dataView[index],
                      rank: 1 + index,
                    ),
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: AppSize.s24,
                  ),
                ),
                state.allItems.to < state.allItems.total ? GestureDetector(
                  onTap: () {
                    log("initial2222222**********************************************************************************************${cubit.afterIncreasePaginate}");
                    cubit.increasePaginate(paginate: cubit.afterIncreasePaginate);
                    context.read<GetAllItemsCubit>().fetchAllItems(
                      paginate: cubit.afterIncreasePaginate,
                    );
                  },
                  child: SizedBox(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width * .05,
                    child: Column(
                      children: [
                        Text(
                          "See more",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.grey.shade600,
                          size: AppSize.s30,
                        )
                      ],
                    ),
                  ),
                ) : const SizedBox(height: 0.0, width: 0.0,),
              ],
            );
          } else if(state is GetAllItemsFailure) {
            return Text(state.errorMessage);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
    );
  }
}
