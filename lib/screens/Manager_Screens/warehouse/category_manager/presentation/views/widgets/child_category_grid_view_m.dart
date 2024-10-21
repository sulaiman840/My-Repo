import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/localization/app_localizations.dart';
import '../../../../../../warehouse_home/category_warehouse/data/models/get_all_category_model.dart';
import '../../../../item_manager/presentation/views/all_item_view_manager.dart';
import 'child_category_grid_view_item_m.dart';

class ChildCategoryGridViewM extends StatelessWidget {
  const ChildCategoryGridViewM({Key? key, required this.typeId, required this.childCategory}) : super(key: key);

  final int typeId;
  final List<GetAllCategoryModel> childCategory;

  @override
  Widget build(BuildContext context) {
    return childCategory.isEmpty ? Center(child: Center(child: Text(AppLocalizations.of(context).translate('empty_list_message')),),)
        : GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: childCategory.length,
      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:6,
        crossAxisSpacing: 18,
        mainAxisSpacing: 6,
      ),
      itemBuilder: (context,index)=> ChildCategoryGridViewItemM(
        allCategoryModel: childCategory[index],
        onTap: () {
          int categoryId = childCategory[index].id;
          context.go('/AllItemViewManager/$typeId/$categoryId');
          /*Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_)=> AllItemViewManager(
                typeId: typeId,
                categoryId: childCategory[index].id,
              ),
            ),
          );*/
        },
      ),
    );
  }
}
