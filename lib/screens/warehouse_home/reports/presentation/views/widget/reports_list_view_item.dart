import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_manager.dart';
import '../../../../../../core/utils/color_manager.dart';
import '../../../../../../core/utils/style_manager.dart';
import '../../../../../../widgets/custom_snack_bar.dart';
import '../../../../../../widgets/icon_btn_widget.dart';
import '../../../../widget/custom_dialog_widget.dart';
import '../../../data/models/all_report_model.dart';
import '../../manager/all_report_cubit/all_report_cubit.dart';
import '../../manager/delete_report_cubit/delete_report_cubit.dart';
import '../../manager/delete_report_cubit/delete_report_state.dart';
import '../../manager/get_file_cubit/get_file_cubit.dart';

class ReportsListViewItem extends StatelessWidget {
  ReportsListViewItem({Key? key, required this.allReports, required this.rank}) : super(key: key);

  final DataReport allReports;
  final int rank;
  final TextEditingController decreaseQuantityController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteReportCubit, DeleteReportState>(
      listener: (context, state) {
        if (state is DeleteReportSuccess) {
          context.read<AllReportCubit>().fetchAllReports(paginate: 50);
          CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('report_deleted_successfully'),);
          /*ScaffoldMessenger.of(contextInner).showSnackBar(
                      SnackBar(
                          content: Text(AppLocalizations.of(context).translate('report_deleted_successfully'))),
                    );*/
        } else if (state is DeleteReportFailure) {
          CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('report_deleted_failed'),);
          /*ScaffoldMessenger.of(contextInner).showSnackBar(
                      SnackBar(
                          content: Text(AppLocalizations.of(context).translate('report_deleted_failed'))),
                    );*/
        }
      },
      builder: (context, state) {
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
                        /*const SizedBox(height: AppSize.s8,),
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
                  Tooltip(
                    message: AppLocalizations.of(context).translate('delete'),
                    child: IconBtnWidget(
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
                                    DeleteReportCubit.get(context).fetchDeleteReport(id: allReports.id);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(AppLocalizations.of(context).translate('delete')),
                                ),
                              ],
                            );
                          },
                        );
                        //DeleteReportCubit.get(context).fetchDeleteReport(id: allReports.id);
                      },
                      icon: Icons.delete,
                      color: ColorManager.orange,
                    ),
                  ),
                  const SizedBox(height: AppSize.s20,),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
