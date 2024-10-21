import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/localization/app_localizations.dart';
import '../../../../../../../core/utils/app_manager.dart';
import '../../../../../../warehouse_home/item_warehouse/data/models/all_items_model.dart';
import '../../../../../../warehouse_home/item_warehouse/data/models/expired_items_model.dart';
import '../../../../../../warehouse_home/item_warehouse/data/models/expiring_soon_items_model.dart';
import '../../../../../../warehouse_home/item_warehouse/presentation/manager/expired_cubit/expired_cubit.dart';
import '../../../../../../warehouse_home/item_warehouse/presentation/manager/expired_cubit/expired_state.dart';
import '../../../../../../warehouse_home/item_warehouse/presentation/manager/expiring_soon_cubit/expiring_soon_cubit.dart';
import '../../../../../../warehouse_home/item_warehouse/presentation/manager/expiring_soon_cubit/expiring_soon_state.dart';
import '../../../../../../warehouse_home/item_warehouse/presentation/manager/get_all_items_cubit/get_all_items_cubit.dart';
import '../../../../../../warehouse_home/item_warehouse/presentation/manager/get_all_items_cubit/get_all_items_state.dart';
import '../../../../../../warehouse_home/item_warehouse/presentation/views/item_details_view.dart';
import 'item_list_view_item_manager.dart';

class ItemListView extends StatelessWidget {
  ItemListView({Key? key, required this.typeId, required this.categoryId}) : super(key: key);

  final int typeId;
  final int categoryId;
  final int paginate = 50;
  List<DataView>? allChildCategory = [];

  @override
  Widget build(BuildContext context) {
    GetAllItemsCubit cubit = GetAllItemsCubit.get(context);
    allChildCategory!.clear();
    return BlocConsumer<GetAllItemsCubit, GetAllItemsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return BlocConsumer<ExpiringSoonCubit, ExpiringSoonState>(
            listener: (contextExpiring, stateExpiring) {

            },
            builder: (contextExpiring, stateExpiring) {
              return BlocConsumer<ExpiredCubit, ExpiredState>(
                listener: (contextExpired, stateExpired) {

                },
                builder: (contextExpired, stateExpired) {
                  allChildCategory!.clear();
                  if(state is GetAllItemsSuccess) {
                    for(int i = 0; i < state.allItems.dataView!.length; i++)
                    {
                      /*log('i ${i}');
                            log('state.allItems.dataView!.length ${state.allItems.dataView!.length}');
                            log('state.allItems.dataView.id ${state.allItems.dataView![i].id}');
                            log('state.allItems.dataView.name ${state.allItems.dataView![i].name}');
                            log('state.allItems.dataView.typeId ${state.allItems.dataView![i].typeId}');
                            log('state.allItems.dataView.categoryId ${state.allItems.dataView![i].categoryId}');*/
                      if(state.allItems.dataView![i].typeId == typeId && state.allItems.dataView![i].categoryId == categoryId) {
                        allChildCategory!.add(state.allItems.dataView![i]);
                      }
                    }
                    log('childCategory ${allChildCategory.toString()}');
                    return allChildCategory!.isEmpty ? Center(child: Center(child: Text(AppLocalizations.of(context).translate('empty_list_message')),),)
                        : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: allChildCategory!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                int id = allChildCategory![index].id;
                                context.go('/ItemDetailsView/$id');
                                /*Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ItemDetailsView(id: allChildCategory![index].id),),
                                );*/
                              },
                              child: ItemListViewItemManager(
                                allItems: allChildCategory![index],
                                rank: 1 + index,
                              ),
                            ),
                            separatorBuilder: (context, index) => const SizedBox(
                              height: AppSize.s24,
                            ),
                          ),
                          state.allItems.to !< state.allItems.total ? GestureDetector(
                            onTap: () {
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
                      ),
                    );
                  } else if(state is GetAllItemsFailure) {
                    return Text(state.errorMessage);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              );
            },
          );
        }
    );
  }
}

class ExpiringItemListView extends StatelessWidget {
  ExpiringItemListView({Key? key, required this.typeId, required this.categoryId}) : super(key: key);

  final int typeId;
  final int categoryId;
  final int paginate = 50;
  List<DataExpiring>? allChildCategory = [];

  @override
  Widget build(BuildContext context) {
    GetAllItemsCubit cubit = GetAllItemsCubit.get(context);
    allChildCategory!.clear();
    return BlocConsumer<ExpiringSoonCubit, ExpiringSoonState>(
        listener: (context, state) {},
        builder: (context, state) {
          allChildCategory!.clear();
          if(state is ExpiringSoonItemsSuccess) {
            for(int i = 0; i < state.allItemsExpiring.dataExpiring!.length; i++)
            {
              /*log('i ${i}');
                      log('state.allItems.dataView!.length ${state.allItemsExpiring.dataExpiring!.length}');
                      log('state.allItems.dataView.id ${state.allItemsExpiring.dataExpiring![i].id}');
                      log('state.allItems.dataView.name ${state.allItemsExpiring.dataExpiring![i].name}');
                      log('state.allItems.dataView.typeId ${state.allItemsExpiring.dataExpiring![i].typeId}');
                      log('state.allItems.dataView.categoryId ${state.allItemsExpiring.dataExpiring![i].categoryId}');*/
              if(state.allItemsExpiring.dataExpiring![i].typeId == typeId && state.allItemsExpiring.dataExpiring![i].categoryId == categoryId) {
                allChildCategory!.add(state.allItemsExpiring.dataExpiring![i]);
              }
            }
            log('childCategory ${allChildCategory.toString()}');
            return allChildCategory!.isEmpty ? Center(child: Center(child: Text(AppLocalizations.of(context).translate('empty_list_message')),),)
                : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: allChildCategory!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        int id = allChildCategory![index].id;
                        context.go('/ItemDetailsView/$id');
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ItemDetailsView(id: allChildCategory![index].id),),
                        );*/
                      },
                      child: ExpiringItemListViewItemM(
                        allItems: allChildCategory![index],
                        rank: 1 + index,
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: AppSize.s24,
                    ),
                  ),
                  state.allItemsExpiring.to !< state.allItemsExpiring.total ? GestureDetector(
                    onTap: () {
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
              ),
            );
          } else if(state is ExpiringSoonItemsFailure) {
            return Text(state.errorMessage);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
    );
  }
}

class ExpiredItemListView extends StatelessWidget {
  ExpiredItemListView({Key? key, required this.typeId, required this.categoryId}) : super(key: key);

  final int typeId;
  final int categoryId;
  final int paginate = 50;
  List<DataExpired>? allChildCategory = [];

  @override
  Widget build(BuildContext context) {
    GetAllItemsCubit cubit = GetAllItemsCubit.get(context);
    allChildCategory!.clear();
    return BlocConsumer<ExpiredCubit, ExpiredState>(
        listener: (context, state) {},
        builder: (context, state) {
          allChildCategory!.clear();
          if(state is ExpiredItemsSuccess) {
            for(int i = 0; i < state.allItemsExpired.dataExpired!.length; i++)
            {
              /*log('i ${i}');
                      log('state.allItems.dataView!.length ${state.allItemsExpired.dataExpired!.length}');
                      log('state.allItems.dataView.id ${state.allItemsExpired.dataExpired![i].id}');
                      log('state.allItems.dataView.name ${state.allItemsExpired.dataExpired![i].name}');
                      log('state.allItems.dataView.typeId ${state.allItemsExpired.dataExpired![i].typeId}');
                      log('state.allItems.dataView.categoryId ${state.allItemsExpired.dataExpired![i].categoryId}');*/
              if(state.allItemsExpired.dataExpired![i].typeId == typeId && state.allItemsExpired.dataExpired![i].categoryId == categoryId) {
                allChildCategory!.add(state.allItemsExpired.dataExpired![i]);
              }
            }
            log('childCategory ${allChildCategory.toString()}');
            return allChildCategory!.isEmpty ? Center(child: Center(child: Text(AppLocalizations.of(context).translate('empty_list_message')),),)
                : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: allChildCategory!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        int id = allChildCategory![index].id;
                        context.go('/ItemDetailsView/$id');
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ItemDetailsView(id: allChildCategory![index].id),),
                        );*/
                      },
                      child: ExpiredItemListViewItemM(
                        allItems: allChildCategory![index],
                        rank: 1 + index,
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: AppSize.s24,
                    ),
                  ),
                  state.allItemsExpired.to !< state.allItemsExpired.total ? GestureDetector(
                    onTap: () {
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
              ),
            );
          } else if(state is ExpiredItemsFailure) {
            return Text(state.errorMessage);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
    );
  }
}
/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/localization/app_localizations.dart';
import '../../../../../../../core/utils/app_manager.dart';
import '../../../../../../warehouse_home/item_warehouse/presentation/manager/get_all_items_cubit/get_all_items_cubit.dart';
import '../../../../../../warehouse_home/item_warehouse/presentation/manager/get_all_items_cubit/get_all_items_state.dart';
import '../../../../../../warehouse_home/item_warehouse/presentation/views/item_details_view.dart';
import 'item_list_view_item_manager.dart';

class ItemListViewManager extends StatelessWidget {
  const ItemListViewManager({Key? key}) : super(key: key);

  final int paginate = 50;

  @override
  Widget build(BuildContext context) {
    GetAllItemsCubit cubit = GetAllItemsCubit.get(context);
    return BlocBuilder<GetAllItemsCubit, GetAllItemsState>(
        builder: (context, state) {
          if(state is GetAllItemsSuccess) {
            return state.allItems.dataView!.isEmpty ? Center(child: Center(child: Text(AppLocalizations.of(context).translate('empty_list_message')),),)
                : Column(
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.allItems.dataView!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ItemDetailsView(id: state.allItems.dataView![index].id),),
                      );
                    },
                    child: ItemListViewItemManager(
                      allItems: state.allItems.dataView![index],
                      rank: 1 + index,
                    ),
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: AppSize.s24,
                  ),
                ),
                state.allItems.to !< state.allItems.total ? GestureDetector(
                  onTap: () {
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
          } else if(state is GetAllItemsFailure) {
            return Text(state.errorMessage);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
    );
  }
}
*/
