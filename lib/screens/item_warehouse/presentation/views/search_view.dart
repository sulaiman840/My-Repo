import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/service_locator.dart';
import '../../data/repos/item_repo_impl.dart';
import '../manager/delete_item_cubit/delete_item_cubit.dart';
import '../manager/search_item_cubit/search_item_cubit.dart';
import 'widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key, required this.typeId, required this.categoryId}) : super(key: key);

  final int typeId;
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
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
    );
  }
}
