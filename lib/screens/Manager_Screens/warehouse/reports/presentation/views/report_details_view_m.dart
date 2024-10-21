import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/service_locator.dart';
import '../../../../../../widgets/general_widgets/common_scaffold.dart';
import '../../../../../warehouse_home/home/widget/common_scaffold_wear_house.dart';
import '../../../../../warehouse_home/reports/data/repos/report_repo_impl.dart';
import '../../../../../warehouse_home/reports/presentation/manager/details_report_cubit/details_report_cubit.dart';
import 'widgets/report_details_view_body_m.dart';

class ReportDetailsViewM extends StatelessWidget {
  ReportDetailsViewM({Key? key, required this.id}) : super(key: key);

  final int id;
  final _keyScaffold  = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return CommonScaffoldWearHouse(
      title: AppLocalizations.of(context).translate('details'),
      scaffoldKey: _keyScaffold,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) {
                return DetailsReportCubit(
                  getIt.get<ReportRepoImpl>(),
                )..fetchReportById(id: id);
              }
          ),
        ],
        child: ReportDetailsViewBodyM(),
      ),
    );
  }
}
