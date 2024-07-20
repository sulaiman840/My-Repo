import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/service_locator.dart';
import '../../data/repos/staff_repo_impl.dart';
import '../manger/create_staff_cubit/create_staff_cubit.dart';
import 'widgets/create_staff_view_body.dart';

class CreateStaffView extends StatelessWidget {
  const CreateStaffView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CreateStaffCubit(
          getIt.get<StaffRepoImpl>(),
        );
      },
      child: const Scaffold(
        body: CreateStaffViewBody(),
      ),
    );
  }
}
