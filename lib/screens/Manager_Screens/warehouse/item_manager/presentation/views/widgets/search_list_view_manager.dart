import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/utils/app_manager.dart';
import '../../../../../../warehouse_home/item_warehouse/presentation/manager/search_item_cubit/search_item_cubit.dart';
import '../../../../../../warehouse_home/item_warehouse/presentation/manager/search_item_cubit/search_item_state.dart';
import 'search_list_view_item_manager.dart';

class SearchListViewManager extends StatelessWidget {
  const SearchListViewManager({Key? key, required this.name, required this.maxQuantity, required this.minQuantity, required this.typeId, required this.categoryId,}) : super(key: key);

  final String name;
  final int typeId;
  final int categoryId;
  final int maxQuantity;
  final int minQuantity;
  final int paginate = 50;

  @override
  Widget build(BuildContext context) {
    SearchItemCubit cubit = SearchItemCubit.get(context);
    log("initial**********************************************************************************************${cubit.afterIncreasePaginate}");
    return BlocConsumer<SearchItemCubit, SearchItemState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          if(state is SearchItemSuccess) {
            log("initial111111**********************************************************************************************${cubit.afterIncreasePaginate}");
            return state.allSearchItems.dataSearch.isEmpty ? const Center(child: Center(child: Text("There are no results to display."),),)
                : Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.allSearchItems.dataSearch.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      /*Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => StaffDetailsView(id: state.allStaff[index].id),),
                              );*/
                    },
                    child: SearchListViewItemManager(
                      allSearchItems: state.allSearchItems.dataSearch[index],
                      rank: 1 + index,
                    ),
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: AppSize.s24,
                  ),
                ),
                state.allSearchItems.to < state.allSearchItems.total ? GestureDetector(
                  onTap: () {
                    log("initial2222222**********************************************************************************************${cubit.afterIncreasePaginate}");
                    cubit.increasePaginate(paginate: cubit.afterIncreasePaginate);
                    //print("$name $typeId $categoryId $minQuantity $maxQuantity $paginate");
                    context.read<SearchItemCubit>().fetchSearchItem(
                      name: name,
                      typeId: typeId,
                      categoryId: categoryId,
                      status: 1,
                      minQuantity: minQuantity,
                      maxQuantity: maxQuantity,
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
          } else if(state is SearchItemFailure) {
            return Text(state.errorMessage);
          } else if(state is SearchItemLoading){
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Center(child: Text("Please enter search query"),),);
          }
        }
    );
  }
}
