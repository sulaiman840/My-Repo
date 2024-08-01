import 'package:flutter/material.dart';
import 'package:project2/core/utils/assets_manager.dart';
import 'package:project2/screens/staff/data/models/show_all_staff_model.dart';
import 'package:project2/screens/staff/presentation/manger/delete_staff_cubit/delete_staff_cubit.dart';
import 'package:project2/screens/staff/presentation/views/update_staff_view.dart';

import '../../../../../core/utils/app_manager.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/style_manager.dart';
import '../../../../../widgets/icon_btn_widget.dart';
import 'custom_image_network.dart';

class StaffsListViewItem extends StatelessWidget {
  const StaffsListViewItem({
    super.key,
    required this.allStaff,
    required this.rank,
  });
  final ShowAllStaffModel allStaff;
  final String rank;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints.tightFor(
            width: MediaQuery.of(context).size.width / 1,
            height: 80.0,
          ),
          padding:const EdgeInsetsDirectional.symmetric(
            vertical: AppPadding.p16,
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
                rank.toString(),
                style: StyleManager.body1Regular(),
              ),
              const SizedBox(width: AppSize.s50,),
              const CustomImageNetwork(image: AssetsManager.testImage,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.007,
              ),
              Text(
                allStaff.name,
                style: StyleManager.body1Regular(),
              ),
              const Spacer(),
              Text(
                allStaff.role,
                style: StyleManager.body1Regular(
                ),
              ),
              const Spacer(),
              Text(
                allStaff.createdAt.replaceRange(10, 27, ""),
                style: StyleManager.body1Regular(color: ColorManager.blackColor),
              ),
              const SizedBox(width: AppSize.s50,),
              const Spacer(),
              IconBtnWidget(
                onPressed: ()
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UpdateStaffView(
                      allStaff: allStaff,
                    ),),
                  );
                },
                icon: Icons.edit,
                color: ColorManager.blue2,
              ),
              IconBtnWidget(
                onPressed: ()
                {
                  DeleteStaffCubit.get(context).fetchDeleteStaff(id: allStaff.id);
                },
                icon: Icons.delete,
                color: ColorManager.orange,
              ),
              const SizedBox(height: AppSize.s20,),
            ],
          ),
        )
      ],
    );
  }
}
