import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/screens/staff/presentation/manger/staff_details_cubit/staff_details_cubit.dart';
import 'package:project2/screens/staff/presentation/manger/staff_details_cubit/staff_details_state.dart';

import '../../../../core/utils/service_locator.dart';
import '../../data/repos/staff_repo_impl.dart';
import '../manger/delete_staff_cubit/delete_staff_cubit.dart';
import 'widgets/staff_details_view_body.dart';

class StaffDetailsView extends StatelessWidget {
  const StaffDetailsView({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return StaffDetailsCubit(
              getIt.get<StaffRepoImpl>(),
            )..fetchStaffDetails(id: id);
          },
        ),
        BlocProvider(
          create: (context) {
            return DeleteStaffCubit(
              getIt.get<StaffRepoImpl>(),
            );
          },
        ),
      ],
      child: const Scaffold(
        body: StaffDetailsViewBody(),
      ),
    );
  }
}
