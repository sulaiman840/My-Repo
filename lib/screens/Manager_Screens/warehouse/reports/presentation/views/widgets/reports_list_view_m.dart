import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/localization/app_localizations.dart';
import '../../../../../../../core/utils/app_manager.dart';
import '../../../../../../../widgets/custom_snack_bar.dart';
import '../../../../../../warehouse_home/reports/presentation/manager/all_report_cubit/all_report_cubit.dart';
import '../../../../../../warehouse_home/reports/presentation/manager/all_report_cubit/all_report_state.dart';
import '../../../../../../warehouse_home/reports/presentation/manager/get_file_cubit/get_file_cubit.dart';
import '../../../../../../warehouse_home/reports/presentation/manager/get_file_cubit/get_file_state.dart';
import '../report_details_view_m.dart';
import 'reports_list_view_item_m.dart';

class ReportsListViewM extends StatelessWidget {
  const ReportsListViewM({Key? key}) : super(key: key);

  final int paginate = 50;

  @override
  Widget build(BuildContext context) {
    AllReportCubit cubit = AllReportCubit.get(context);
    return BlocConsumer<AllReportCubit, AllReportState>(
        listener: (context, state) {

        },
        builder: (context, state) {
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
                      context.go('/ReportDetailsViewM/$id');
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReportDetailsViewM(id: state.allReport.dataReport![index].id),),
                      );*/
                    },
                    child: ReportsListViewItemM(
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
        }
    );
  }
}
