import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/utils/app_manager.dart';
import '../../manager/delete_item_cubit/delete_item_cubit.dart';
import '../../manager/delete_item_cubit/delete_item_state.dart';
import '../../manager/get_all_items_cubit/get_all_items_cubit.dart';
import '../../manager/get_all_items_cubit/get_all_items_state.dart';
import '../item_details_view.dart';
import 'item_list_view_item.dart';

class ItemListView extends StatelessWidget {
  const ItemListView({Key? key}) : super(key: key);

  final int paginate = 50;

  @override
  Widget build(BuildContext context) {
    GetAllItemsCubit cubit = GetAllItemsCubit.get(context);
    log("initial**********************************************************************************************${cubit.afterIncreasePaginate}");
    return BlocConsumer<GetAllItemsCubit, GetAllItemsState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return BlocConsumer<DeleteItemCubit, DeleteItemState>(
          listener: (contextInner, stateInner) {
            if (stateInner is DeleteItemSuccess) {
              contextInner.read<GetAllItemsCubit>().fetchAllItems(
                paginate: paginate
              );
              ScaffoldMessenger.of(contextInner).showSnackBar(
                const SnackBar(content: Text("Item deleted successfully")),
              );
            } else if (stateInner is DeleteItemFailure) {
              ScaffoldMessenger.of(contextInner).showSnackBar(
                const SnackBar(content: Text("Item deleted failed")),
              );
            }
          },
          builder: (contextInner, stateInner) {
            if(state is GetAllItemsSuccess) {
              return Column(
                children: [
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.allItems.dataView.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ItemDetailsView(id: state.allItems.dataView[index].id),),
                        );
                      },
                      child: ItemListViewItem(
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
                      contextInner.read<GetAllItemsCubit>().fetchAllItems(
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
          },
        );
      }
    );
  }
}