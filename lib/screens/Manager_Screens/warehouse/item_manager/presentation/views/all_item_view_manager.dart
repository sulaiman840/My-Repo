import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/color_manager.dart';
import '../../../../../../core/utils/service_locator.dart';
import '../../../../../../widgets/general_widgets/common_scaffold.dart';
import '../../../../../warehouse_home/item_warehouse/data/repos/item_repo_impl.dart';
import '../../../../../warehouse_home/item_warehouse/presentation/manager/delete_item_cubit/delete_item_cubit.dart';
import '../../../../../warehouse_home/item_warehouse/presentation/manager/get_all_items_cubit/get_all_items_cubit.dart';
import 'widgets/all_item_view_body_manager.dart';

class AllItemViewManager extends StatelessWidget {
  AllItemViewManager({Key? key, required this.typeId, required this.categoryId}) : super(key: key);

  final int typeId;
  final int categoryId;
  final int paginate = 50;
  final _keyScaffold  = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "Items",
      scaffoldKey: _keyScaffold,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return GetAllItemsCubit(
                getIt.get<ItemRepoImpl>(),
              )..fetchAllItems(
                paginate: paginate,
              );
            },
          ),
          BlocProvider(
            create: (context) {
              return DeleteItemCubit(
                getIt.get<ItemRepoImpl>(),
              );
            },
          ),
        ],
        child: AllItemViewBodyManager(
          typeId: typeId,
          categoryId: categoryId,
        ),
      ),
    );
  }
}
