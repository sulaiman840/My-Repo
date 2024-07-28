import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/service_locator.dart';
import '../../data/models/all_items_model.dart';
import '../../data/repos/item_repo_impl.dart';
import '../manager/update_item_cubit/update_item_cubit.dart';
import 'widgets/update_item_view_body.dart';

class UpdateItemView extends StatelessWidget {
  const UpdateItemView({Key? key, required this.allItems}) : super(key: key);

  final DataView allItems;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return UpdateItemCubit(
          getIt.get<ItemRepoImpl>(),
        );
      },
      child: UpdateItemViewBody(allItems: allItems,),
    );
  }
}
