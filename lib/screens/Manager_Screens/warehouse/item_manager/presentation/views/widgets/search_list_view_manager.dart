import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/localization/app_localizations.dart';
import '../../../../../../../core/utils/app_manager.dart';
import '../../../../../../warehouse_home/item_warehouse/data/models/search_items_model.dart';
import '../../../../../../warehouse_home/item_warehouse/presentation/manager/search_item_cubit/search_item_cubit.dart';
import '../../../../../../warehouse_home/item_warehouse/presentation/manager/search_item_cubit/search_item_state.dart';
import '../../../../../../warehouse_home/item_warehouse/presentation/views/item_details_view.dart';
import 'search_list_view_item_manager.dart';

class SearchListViewManager extends StatelessWidget {
  SearchListViewManager({Key? key, required this.name, required this.maxQuantity, required this.minQuantity, required this.typeId, required this.categoryId,}) : super(key: key);

  final String name;
  final int typeId;
  final int categoryId;
  final int maxQuantity;
  final int minQuantity;
  final int paginate = 50;
  List<DataSearch>? allChildCategory = [];

  @override
  Widget build(BuildContext context) {
    SearchItemCubit cubit = SearchItemCubit.get(context);
    allChildCategory!.clear();
    return BlocConsumer<SearchItemCubit, SearchItemState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          allChildCategory!.clear();
          if(state is SearchItemSuccess) {
            for(int i = 0; i < state.allSearchItems.dataSearch!.length; i++)
            {
              /*log('i ${i}');
                      log('state.allItems.dataView!.length ${state.allSearchItems.dataSearch!.length}');
                      log('state.allItems.dataView.id ${state.allSearchItems.dataSearch![i].id}');
                      log('state.allItems.dataView.name ${state.allSearchItems.dataSearch![i].name}');
                      log('state.allItems.dataView.typeId ${state.allSearchItems.dataSearch![i].typeId}');
                      log('state.allItems.dataView.categoryId ${state.allSearchItems.dataSearch![i].categoryId}');*/
              if(state.allSearchItems.dataSearch![i].typeId == typeId && state.allSearchItems.dataSearch![i].categoryId == categoryId) {
                allChildCategory!.add(state.allSearchItems.dataSearch![i]);
              }
            }
            log('childCategory ${allChildCategory.toString()}');
            return allChildCategory!.isEmpty ? Center(child: Center(child: Text(AppLocalizations.of(context).translate('empty_list_message')),),)
                : Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: allChildCategory!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      int id = allChildCategory![index].id;
                      context.go('/ItemDetailsView/$id');
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDetailsView(id: allChildCategory![index].id,),));
                    },
                    child: SearchListViewItemManager(
                      allSearchItems: allChildCategory![index],
                      rank: 1 + index,
                    ),
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: AppSize.s24,
                  ),
                ),
                state.allSearchItems.to !< state.allSearchItems.total ? GestureDetector(
                  onTap: () {
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
                          AppLocalizations.of(context).translate('see_more'),
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
            return Center(child: Center(child: Text(AppLocalizations.of(context).translate('enter_search_query')),),);
          }
        }
    );
  }
}
