import 'package:flutter/material.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../../home/widget/common_scaffold_wear_house.dart';
import '../../data/models/get_all_category_model.dart';
import 'widgets/all_child_category_view_body.dart';

class AllChildCategoryView extends StatelessWidget {
  AllChildCategoryView({Key? key, this.typeId, required this.childCategory}) : super(key: key);

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
        child: childCategory == null ? Center(child: Center(child: Text(AppLocalizations.of(context).translate('empty_list_message')),),)
            : AllChildCategoryViewBody(
          typeId: typeId!,
          childCategory: childCategory!,
        ),
      ),
    );
  }
}
