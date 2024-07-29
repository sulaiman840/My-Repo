import 'package:flutter/material.dart';

import '../../../../../core/utils/app_manager.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/style_manager.dart';
import '../../../../warehouse_home/widget/circular_icon_widget.dart';
import '../create_staff_view.dart';
import 'staffs_list_view.dart';

class StaffsViewBody extends StatelessWidget {
  const StaffsViewBody({Key? key}) : super(key: key);

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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  height: AppSize.s24,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreateStaffView(),)
                    );
                  },
                  child: circleIconWidget(
                    icon: Icons.add,
                    backgroundColor: ColorManager.blue,
                    color: ColorManager.bc0,
                    size: AppSize.s24,
                    radius: AppSize.s20,
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Container(
                  constraints: BoxConstraints.tightFor(
                    width: MediaQuery.of(context).size.width / 1,
                    height: 45.0,
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
                        "Role",
                        style: StyleManager.body1Regular(color: ColorManager.blackColor),
                      ),
                      const Spacer(),
                      Text(
                        "Date of join",
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
            const StaffsListView(),
          ],
        ),
      ),
    );
  }
}
