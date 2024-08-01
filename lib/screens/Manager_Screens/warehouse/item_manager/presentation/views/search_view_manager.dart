import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/service_locator.dart';
import '../../../../../../widgets/general_widgets/common_scaffold.dart';
import '../../../../../warehouse_home/item_warehouse/data/repos/item_repo_impl.dart';
import '../../../../../warehouse_home/item_warehouse/presentation/manager/search_item_cubit/search_item_cubit.dart';
import 'widgets/search_view_body_manager.dart';

class SearchViewManager extends StatelessWidget {
  SearchViewManager({Key? key, required this.typeId, required this.categoryId}) : super(key: key);

  final int typeId;
  final int categoryId;
  final _keyScaffold  = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "Search",
      scaffoldKey: _keyScaffold,
      body: BlocProvider(
        create: (context) {
          return SearchItemCubit(
            getIt.get<ItemRepoImpl>(),
          );
        },
        child: SearchViewBodyManager(
          typeId: typeId,
          categoryId: categoryId,
        ),
      ),
    );
  }
}
