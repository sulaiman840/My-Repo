import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/service_locator.dart';
import '../../../../../../widgets/general_widgets/common_scaffold.dart';
import '../../../../../warehouse_home/reports/data/repos/report_repo_impl.dart';
import '../../../../../warehouse_home/reports/presentation/manager/all_report_cubit/all_report_cubit.dart';
import 'widgets/all_report_view_body_m.dart';

class AllReportViewM extends StatelessWidget {
  AllReportViewM({super.key});

  static const String id ='ReportScreen';
  final _keyScaffold  = GlobalKey<ScaffoldState>();
  final int paginate = 50;

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: AppLocalizations.of(context).translate('report_title'),
      scaffoldKey: _keyScaffold,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return AllReportCubit(
                getIt.get<ReportRepoImpl>(),
              )..fetchAllReports(paginate: paginate);
            },
          ),
        ],
        child: AllReportViewBodyM(),
      ),
    );
  }
}