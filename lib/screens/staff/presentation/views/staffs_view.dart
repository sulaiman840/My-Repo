import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/screens/staff/presentation/manger/delete_staff_cubit/delete_staff_cubit.dart';

import '../../../../core/utils/service_locator.dart';
import '../../data/repos/staff_repo_impl.dart';
import 'widgets/staffs_view_body.dart';

class StaffsView extends StatelessWidget {
  const StaffsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return DeleteStaffCubit(
              getIt.get<StaffRepoImpl>(),
            );
          },
        ),
      ],
      child: const Scaffold(
        body: StaffsViewBody(),
      ),
    );
  }
}
