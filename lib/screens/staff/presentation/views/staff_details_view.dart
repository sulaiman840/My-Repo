import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/screens/staff/presentation/manger/staff_details_cubit/staff_details_cubit.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/service_locator.dart';
import '../../data/repos/staff_repo_impl.dart';
import 'widgets/staff_details_view_body.dart';

class StaffDetailsView extends StatelessWidget {
  const StaffDetailsView({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return StaffDetailsCubit(
          getIt.get<StaffRepoImpl>(),
        )..fetchStaffDetails(id: id);
      },
      child: Scaffold(
        backgroundColor: ColorManager.bc0,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: const StaffDetailsViewBody(),
      ),
    );
  }
}
