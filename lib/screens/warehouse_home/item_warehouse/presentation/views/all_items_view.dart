import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/service_locator.dart';
import '../../../../../widgets/general_widgets/common_scaffold.dart';
import '../../data/repos/item_repo_impl.dart';
import '../manager/delete_item_cubit/delete_item_cubit.dart';
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
    return CommonScaffold(
      title: "WareHouse Manager",
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
          BlocProvider(
            create: (context) => ExportToExcelCubit(
              getIt.get<ItemRepoImpl>(),
            ),
          ),
        ],
        child: AllItemsBody(
          typeId: typeId,
          categoryId: categoryId,
        ),
      ),
    );
  }
}
