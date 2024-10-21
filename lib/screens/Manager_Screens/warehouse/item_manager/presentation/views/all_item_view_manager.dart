import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/service_locator.dart';
import '../../../../../../widgets/general_widgets/common_scaffold.dart';
import '../../../../../warehouse_home/home/widget/common_scaffold_wear_house.dart';
import '../../../../../warehouse_home/item_warehouse/data/repos/item_repo_impl.dart';
import '../../../../../warehouse_home/item_warehouse/presentation/manager/delete_item_cubit/delete_item_cubit.dart';
import '../../../../../warehouse_home/item_warehouse/presentation/manager/expired_cubit/expired_cubit.dart';
import '../../../../../warehouse_home/item_warehouse/presentation/manager/expiring_soon_cubit/expiring_soon_cubit.dart';
import '../../../../../warehouse_home/item_warehouse/presentation/manager/export_to_excel_cubit/export_to_excel_cubit.dart';
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
    return CommonScaffoldWearHouse(
      title: AppLocalizations.of(context).translate('items_title'),
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
          BlocProvider(
            create: (context) => ExportToExcelCubit(
              getIt.get<ItemRepoImpl>(),
            ),
          ),
          BlocProvider(
            create: (context) {
              return ExpiringSoonCubit(
                getIt.get<ItemRepoImpl>(),
              )..fetchExpiringSoonItems(
                  paginate: paginate
              );
            },
          ),
          BlocProvider(
            create: (context) {
              return ExpiredCubit(
                getIt.get<ItemRepoImpl>(),
              )..fetchExpiredItems(
                  paginate: paginate
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
