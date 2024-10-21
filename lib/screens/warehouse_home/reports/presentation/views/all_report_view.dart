import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../../../widgets/general_widgets/common_scaffold.dart';
import '../../../home/widget/common_scaffold_wear_house.dart';
import '../../data/repos/report_repo_impl.dart';
import '../manager/all_report_cubit/all_report_cubit.dart';
import '../manager/create_report_cubit/create_report_cubit.dart';
import '../manager/delete_report_cubit/delete_report_cubit.dart';
import '../manager/get_file_cubit/get_file_cubit.dart';
import 'widget/all_report_view_body.dart';

class AllReportView extends StatelessWidget {
  AllReportView({super.key});

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
          BlocProvider(
            create: (context) {
              return DeleteReportCubit(
                getIt.get<ReportRepoImpl>(),
              );
            },
          ),

        ],
        child: Container(
          color: Colors.white,
          child: AllReportViewBody(),
        ),
      ),
    );
  }
}