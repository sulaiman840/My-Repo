import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/service_locator.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../home/widget/common_scaffold_wear_house.dart';
import '../../data/models/all_items_model.dart';
import '../../data/models/expiring_soon_items_model.dart';
import '../../data/models/search_items_model.dart';
import '../../data/repos/item_repo_impl.dart';
import '../manager/update_item_cubit/update_item_cubit.dart';
import 'widgets/update_item_view_body.dart';

class UpdateItemView extends StatelessWidget {
  UpdateItemView({Key? key, required this.allItems}) : super(key: key);

  final DataView allItems;
  final _keyScaffold  = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWearHouse(
      title: AppLocalizations.of(context).translate('warehouse_home_title'),
      scaffoldKey: _keyScaffold,
      body: BlocProvider(
        create: (context) {
          return UpdateItemCubit(
            getIt.get<ItemRepoImpl>(),
          );
        },
        child: Container(
          color: Colors.white,
          child: UpdateItemViewBody(
            allItems: allItems,
          ),
        ),
      ),
    );
  }
}

class UpdateExpiringItemView extends StatelessWidget {
  UpdateExpiringItemView({Key? key, required this.allItems}) : super(key: key);

  final DataExpiring allItems;
  final _keyScaffold  = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWearHouse(
      title: AppLocalizations.of(context).translate('warehouse_home_title'),
      scaffoldKey: _keyScaffold,
      body: BlocProvider(
        create: (context) {
          return UpdateItemCubit(
            getIt.get<ItemRepoImpl>(),
          );
        },
        child: Container(
          color: Colors.white,
          child: UpdateExpiringItemViewBody(
            allItems: allItems,
          ),
        ),
      ),
    );
  }
}

class UpdateSearchItemView extends StatelessWidget {
  UpdateSearchItemView({Key? key, required this.allItems}) : super(key: key);

  final DataSearch allItems;
  final _keyScaffold  = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWearHouse(
      title: AppLocalizations.of(context).translate('warehouse_home_title'),
      scaffoldKey: _keyScaffold,
      body: BlocProvider(
        create: (context) {
          return UpdateItemCubit(
            getIt.get<ItemRepoImpl>(),
          );
        },
        child: Container(
          color: Colors.white,
          child: UpdateSearchItemViewBody(
            allItems: allItems,
          ),
        ),
      ),
    );
  }
}