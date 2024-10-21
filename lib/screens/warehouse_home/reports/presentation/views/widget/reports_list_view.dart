import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_manager.dart';
import '../../../../../../widgets/custom_snack_bar.dart';
import '../../manager/all_report_cubit/all_report_cubit.dart';
import '../../manager/all_report_cubit/all_report_state.dart';
import '../../manager/delete_report_cubit/delete_report_cubit.dart';
import '../../manager/delete_report_cubit/delete_report_state.dart';
import '../../manager/get_file_cubit/get_file_cubit.dart';
import '../../manager/get_file_cubit/get_file_state.dart';
import '../report_details_view.dart';
import 'reports_list_view_item.dart';

class ReportsListView extends StatelessWidget {
  const ReportsListView({Key? key}) : super(key: key);

  final int paginate = 50;

  @override
  Widget build(BuildContext context) {
    AllReportCubit cubit = AllReportCubit.get(context);
    return BlocConsumer<AllReportCubit, AllReportState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return BlocConsumer<GetFileCubit, GetFileState>(
            listener: (contextGetFile, stateGetFile) {
              if (stateGetFile is GetFileSuccess) {
                //contextGetFile.read<GetFileCubit>().fetchAllReports(paginate: paginate);
                CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('get_file_successfully'),);
                /*ScaffoldMessenger.of(contextGetFile).showSnackBar(
                  SnackBar(
                      content: Text("file successfully"*//*AppLocalizations.of(context).translate('report_deleted_successfully')*//*)),
                );*/
              } else if (stateGetFile is GetFileFailure) {
                CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('get_file_failed'),);
                /*ScaffoldMessenger.of(contextGetFile).showSnackBar(
                  SnackBar(
                      content: Text("file failed"*//*AppLocalizations.of(context).translate('report_deleted_failed')*//*)),
                );*/
              }
            },
            builder: (contextGetFile, stateGetFile) {
              if (state is AllReportSuccess) {
                return state.allReport.dataReport!.isEmpty ? Center(
                  child: Center(
                    child: Text(AppLocalizations.of(context).translate('empty_list_message')),
                  ),
                )
                    : Column(
                  children: [
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.allReport.dataReport!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          int id = state.allReport.dataReport![index].id;
                          context.go('/ReportDetailsView/$id');
                          /*Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ReportDetailsView(id: state.allReport.dataReport![index].id),),
                                    );*/
                        },
                        child: ReportsListViewItem(
                          allReports: state.allReport.dataReport![index],
                          rank: 1 + index,
                        ),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: AppSize.s24,
                      ),
                    ),
                    state.allReport.to! < state.allReport.total ? GestureDetector(
                      onTap: () {
                        cubit.increasePaginate(paginate: cubit.afterIncreasePaginate);
                        context.read<AllReportCubit>().fetchAllReports(paginate: cubit.afterIncreasePaginate,);
                      },
                      child: SizedBox(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width * .05,
                        child: Column(
                          children: [
                            Text(
                              AppLocalizations.of(context).translate('see_more'),
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Colors.grey.shade600,
                              size: AppSize.s30,
                            )
                          ],
                        ),
                      ),
                    )
                        : const SizedBox(
                      height: 0.0,
                      width: 0.0,
                    ),
                  ],
                );
              } else if (state is AllReportFailure) {
                return Text(state.errorMessage);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        }
    );
  }
}
