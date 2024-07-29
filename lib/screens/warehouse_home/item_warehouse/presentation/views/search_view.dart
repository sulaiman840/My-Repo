import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../../../widgets/general_widgets/common_scaffold.dart';
import '../../data/repos/item_repo_impl.dart';
import '../manager/delete_item_cubit/delete_item_cubit.dart';
import '../manager/search_item_cubit/search_item_cubit.dart';
import 'widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  SearchView({Key? key, required this.typeId, required this.categoryId}) : super(key: key);

  final int typeId;
  final int categoryId;
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
              return SearchItemCubit(
                getIt.get<ItemRepoImpl>(),
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
        child: SearchViewBody(
          typeId: typeId,
          categoryId: categoryId,
        ),
      ),
    );
  }
}
