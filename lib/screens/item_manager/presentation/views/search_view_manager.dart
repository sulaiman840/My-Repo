import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/service_locator.dart';
import '../../../item_warehouse/data/repos/item_repo_impl.dart';
import '../../../item_warehouse/presentation/manager/search_item_cubit/search_item_cubit.dart';
import 'widgets/search_view_body_manager.dart';

class SearchViewManager extends StatelessWidget {
  const SearchViewManager({Key? key, required this.typeId, required this.categoryId}) : super(key: key);

  final int typeId;
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SearchItemCubit(
          getIt.get<ItemRepoImpl>(),
        );
      },
      child: Scaffold(
        body: SearchViewBodyManager(
          typeId: typeId,
          categoryId: categoryId,
        ),
      ),
    );
  }
}
