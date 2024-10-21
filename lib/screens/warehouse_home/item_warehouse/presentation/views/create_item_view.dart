import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/service_locator.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../home/widget/common_scaffold_wear_house.dart';
import '../../data/repos/item_repo_impl.dart';
import '../manager/create_item_cubit/create_item_cubit.dart';
import 'widgets/create_item_view_body.dart';

class CreateItemView extends StatelessWidget {
  CreateItemView({Key? key, required this.typeId, required this.categoryId}) : super(key: key);

  final int typeId;
  final int categoryId;
  final _keyScaffold  = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWearHouse(
      title: AppLocalizations.of(context).translate('warehouse_home_title'),
      scaffoldKey: _keyScaffold,
      body: BlocProvider(
        create: (context) {
          return CreateItemCubit(
            getIt.get<ItemRepoImpl>(),
          );
        },
        child: Container(
          color: Colors.white,
          child: CreateItemViewBody(
            typeId: typeId,
            categoryId: categoryId,
          ),
        )),
    );
  }
}
