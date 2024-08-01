import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/screens/staff/presentation/manger/delete_staff_cubit/delete_staff_state.dart';
import 'package:project2/screens/staff/presentation/manger/featured_staff_cubit/featured_staff_cubit.dart';
import 'package:project2/screens/staff/presentation/manger/featured_staff_cubit/featured_staff_state.dart';
import 'package:project2/screens/staff/presentation/views/staff_details_view.dart';

import '../../../../../core/utils/app_manager.dart';
import '../../manger/delete_staff_cubit/delete_staff_cubit.dart';
import 'staffs_list_view_item.dart';

class StaffsListView extends StatelessWidget {
  const StaffsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeaturedStaffCubit, FeaturedStaffState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return BlocConsumer<DeleteStaffCubit, DeleteStaffState>(
          listener: (contextInner, stateInner) {
            if (stateInner is DeleteStaffFailure) {
              ScaffoldMessenger.of(contextInner).showSnackBar(
                const SnackBar(content: Text("Staff deleted failed")),
              );
            } else if (stateInner is DeleteStaffSuccess) {
              contextInner.read<FeaturedStaffCubit>().fetchFeaturedStaff();
              ScaffoldMessenger.of(contextInner).showSnackBar(
                const SnackBar(content: Text('Staff deleted successfully')),
              );
            }
          },
          builder: (contextInner, stateInner) {
            if (state is FeaturedStaffSuccess) {
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.allStaff.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_)=> StaffDetailsView(id: state.allStaff[index].id),
                      ),
                    );
                  },
                  child: StaffsListViewItem(
                    allStaff: state.allStaff[index],
                    rank: (index + 1).toString(),
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: AppSize.s24,
                ),
              );
            } else if (state is FeaturedStaffFailure) {
              return Text(state.errorMessage);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
  }
}
