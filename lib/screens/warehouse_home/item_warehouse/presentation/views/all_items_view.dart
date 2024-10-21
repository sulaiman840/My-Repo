import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/service_locator.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../home/widget/common_scaffold_wear_house.dart';
import '../../data/repos/item_repo_impl.dart';
import '../manager/check_expiring_cubit/check_expiring_cubit.dart';
import '../manager/delete_item_cubit/delete_item_cubit.dart';
import '../manager/expired_cubit/expired_cubit.dart';
import '../manager/expiring_soon_cubit/expiring_soon_cubit.dart';
import '../manager/export_to_excel_cubit/export_to_excel_cubit.dart';
import '../manager/get_all_items_cubit/get_all_items_cubit.dart';
import '../manager/import_from_excel_cubit/import_from_excel_cubit.dart';
import 'widgets/all_items_body.dart';

class AllItemsView extends StatelessWidget {
  AllItemsView({Key? key, required this.typeId, required this.categoryId}) : super(key: key);

  final int typeId;
  final int categoryId;
  final int paginate = 50;
  final _keyScaffold  = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWearHouse(
      title: AppLocalizations.of(context).translate('warehouse_home_title'),
      scaffoldKey: _keyScaffold,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return GetAllItemsCubit(
                getIt.get<ItemRepoImpl>(),
              )..fetchAllItems(
                paginate: paginate
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
            create: (context) {
              return ImportFromExcelCubit(
                getIt.get<ItemRepoImpl>(),
              );
            },
          ),
          /*BlocProvider(
            create: (context) => ExportToExcelCubit(
              getIt.get<ItemRepoImpl>(),
            ),
          ),*/
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
          BlocProvider(
            create: (context) {
              return CheckExpiringCubit(
                getIt.get<ItemRepoImpl>(),
              );
            },
          ),
        ],
        child: Container(
          color: Colors.white,
          child: AllItemsBody(
            typeId: typeId,
            categoryId: categoryId,
          ),
        ),
      ),
    );
  }
}
