import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/service_locator.dart';
import '../../../../widgets/general_widgets/common_scaffold.dart';
import '../../data/repos/staff_repo_impl.dart';
import '../manger/create_staff_cubit/create_staff_cubit.dart';
import 'widgets/create_staff_view_body.dart';

class CreateStaffView extends StatelessWidget {
  CreateStaffView({Key? key}) : super(key: key);

  final _keyScaffold  = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: "Create staff",
      scaffoldKey: _keyScaffold,
      body: BlocProvider(
        create: (context) {
          return CreateStaffCubit(
            getIt.get<StaffRepoImpl>(),
          );
        },
        child: CreateStaffViewBody(),
      ),
    );
  }
}
