import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project2/screens/staff/data/models/show_all_staff_model.dart';
import 'package:project2/screens/staff/presentation/manger/delete_staff_cubit/delete_staff_cubit.dart';
import 'package:project2/screens/staff/presentation/views/update_staff_view.dart';

import '../../../../../core/localization/app_localizations.dart';
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
              allStaff.imagePath != null ? CustomImageNetwork(image: allStaff.imagePath?.replaceRange(0, 11, ''),) : const CustomImageAsset(),
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
                  context.replace('/UpdateStaffView', extra: allStaff);
                  log(allStaff.id.toString());
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UpdateStaffView(
                      allStaff: allStaff,
                    ),),
                  );*/
                },
                icon: Icons.edit,
                color: ColorManager.blue2,
              ),
              IconBtnWidget(
                onPressed: ()
                {
                  showDialog(
                    context: context,
                    builder: (BuildContext contextD) {
                      return AlertDialog(
                        content: Text(AppLocalizations.of(context).translate('make_sure_delete')),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(AppLocalizations.of(context).translate('cancel')),
                          ),
                          TextButton(
                            onPressed: () {
                              DeleteStaffCubit.get(context).fetchDeleteStaff(id: allStaff.id);
                              Navigator.of(context).pop();
                            },
                            child: Text(AppLocalizations.of(context).translate('delete')),
                          ),
                        ],
                      );
                    },
                  );
                  //DeleteStaffCubit.get(context).fetchDeleteStaff(id: allStaff.id);
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
