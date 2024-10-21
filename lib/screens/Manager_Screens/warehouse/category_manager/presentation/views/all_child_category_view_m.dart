import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../warehouse_home/category_warehouse/data/models/get_all_category_model.dart';
import '../../../../../warehouse_home/home/widget/common_scaffold_wear_house.dart';
import 'widgets/all_child_category_view_body_m.dart';

class AllChildCategoryViewM extends StatelessWidget {
  AllChildCategoryViewM({Key? key, this.typeId, required this.childCategory}) : super(key: key);

  static const String id ='CategoriesScreen';
  final int? typeId;
  final _keyScaffold  = GlobalKey<ScaffoldState>();
  final List<GetAllCategoryModel>? childCategory;

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWearHouse(
      title: AppLocalizations.of(context).translate('warehouse_home_title'),
      scaffoldKey: _keyScaffold,
      body: Container(
        color: Colors.white,
        child: AllChildCategoryViewBodyM(
          typeId: typeId!,
          childCategory: childCategory!,
        ),
      ),
    );
  }
}
