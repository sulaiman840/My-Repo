import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/screens/staff/presentation/manger/staff_details_cubit/staff_details_cubit.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../widgets/general_widgets/common_scaffold.dart';
import '../../data/repos/staff_repo_impl.dart';
import 'widgets/staff_details_view_body.dart';

class StaffDetailsView extends StatelessWidget {
  StaffDetailsView({Key? key, required this.id}) : super(key: key);
  final int id;
  final _keyScaffold  = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "Details",
      scaffoldKey: _keyScaffold,
      body: BlocProvider(
        create: (context) {
          return StaffDetailsCubit(
            getIt.get<StaffRepoImpl>(),
          )..fetchStaffDetails(id: id);
        },
        child: StaffDetailsViewBody(),
      ),
    );
  }
}
