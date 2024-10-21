import 'package:flutter/material.dart';

import '../../../../../../../core/localization/app_localizations.dart';
import '../../../../../../../core/utils/app_manager.dart';
import '../../../../../../../core/utils/color_manager.dart';
import '../../../../../../../core/utils/style_manager.dart';
import '../../../../../../warehouse_home/reports/data/models/all_report_model.dart';

class ReportsListViewItemM extends StatelessWidget {
  ReportsListViewItemM({Key? key, required this.allReports, required this.rank}) : super(key: key);

  final DataReport allReports;
  final int rank;
  final TextEditingController decreaseQuantityController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints.tightFor(
            width: MediaQuery.of(context).size.width / 1,
            height: 70.0,
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
              const SizedBox(width: AppSize.s40,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      allReports.title?? AppLocalizations.of(context).translate('no_title'),
                      style: StyleManager.h3Medium(color: ColorManager.blackColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    /*const Spacer(),
                    Text(
                      allReports.body!,
                      style: StyleManager.body1Regular(color: ColorManager.blackColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),*/
                  ],
                ),
              ),
              const SizedBox(width: AppSize.s50,),
              const Spacer(),
            ],
          ),
        )
      ],
    );
  }
}
