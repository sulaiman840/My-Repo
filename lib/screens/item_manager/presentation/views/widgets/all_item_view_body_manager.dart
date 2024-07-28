import 'package:flutter/material.dart';

import '../../../../../core/utils/app_manager.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/style_manager.dart';
import '../../../../warehouse_home/widget/circular_icon_widget.dart';
import '../search_view_manager.dart';
import 'item_list_view_manager.dart';

class AllItemViewBodyManager extends StatelessWidget {
  const AllItemViewBodyManager({Key? key, required this.typeId, required this.categoryId}) : super(key: key);

  final int typeId;
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: AppPadding.p16,
        start: AppPadding.p16,
        end: AppPadding.p16,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) => SearchViewManager(
                                typeId: typeId,
                                categoryId: categoryId,
                              ),
                              transitionDuration: Duration.zero,
                              transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                            ),
                          );
                        },
                        child: circleIconWidget(
                            icon: Icons.search_sharp,
                            backgroundColor: Colors.transparent,
                            color: ColorManager.blue,
                            radius: 30.0,
                            size: 25.0
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppSize.s24,
                ),
                Container(
                  constraints: BoxConstraints.tightFor(
                    width: MediaQuery.of(context).size.width / 1,
                    height: 50.0,
                  ),
                  padding:const EdgeInsetsDirectional.symmetric(
                    //vertical: AppPadding.p16,
                    horizontal: AppPadding.p16,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.bc2,
                    borderRadius: BorderRadius.circular(AppSize.s12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Rank",
                        style: StyleManager.body1Regular(),
                      ),
                      const SizedBox(width: AppSize.s50,),
                      Center(
                        child: Text(
                          "Name",
                          style: StyleManager.body1Regular(color: ColorManager.blackColor),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "Quantity",
                        style: StyleManager.body1Regular(color: ColorManager.blackColor),
                      ),
                      const SizedBox(height: AppSize.s50,),
                      const Spacer(),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: AppSize.s24,
            ),
            const ItemListViewManager(),
          ],
        ),
      ),
    );
  }
}
