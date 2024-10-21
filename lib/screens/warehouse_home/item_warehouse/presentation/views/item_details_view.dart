import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/core/utils/service_locator.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../../home/widget/common_scaffold_wear_house.dart';
import '../../data/repos/item_repo_impl.dart';
import '../manager/item_by_id_cubit/item_by_id_cubit.dart';
import 'widgets/item_details_view_body.dart';

class ItemDetailsView extends StatelessWidget {
  ItemDetailsView({Key? key, required this.id}) : super(key: key);

  final int id;
  final _keyScaffold  = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWearHouse(
      title: AppLocalizations.of(context).translate('details'),
      scaffoldKey: _keyScaffold,
      body: BlocProvider(
        create: (context) {
          return ItemByIdCubit(
            getIt.get<ItemRepoImpl>(),
          )..fetchItemById(id: id);
        },
        child: ItemDetailsViewBody(),
      ),
    );
  }
}
