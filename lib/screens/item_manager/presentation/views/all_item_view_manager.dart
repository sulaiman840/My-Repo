import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../item_warehouse/data/repos/item_repo_impl.dart';
import '../../../item_warehouse/presentation/manager/delete_item_cubit/delete_item_cubit.dart';
import '../../../item_warehouse/presentation/manager/get_all_items_cubit/get_all_items_cubit.dart';
import 'widgets/all_item_view_body_manager.dart';

class AllItemViewManager extends StatelessWidget {
  const AllItemViewManager({Key? key, required this.typeId, required this.categoryId}) : super(key: key);

  final int typeId;
  final int categoryId;
  final int paginate = 50;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
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
      child: Scaffold(
        backgroundColor: ColorManager.bc0,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: AllItemViewBodyManager(
          typeId: typeId,
          categoryId: categoryId,
        ),
      ),
    );
  }
}
