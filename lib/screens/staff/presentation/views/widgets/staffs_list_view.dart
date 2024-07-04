import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/screens/staff/presentation/manger/featured_staff_cubit/featured_staff_cubit.dart';
import 'package:project2/screens/staff/presentation/manger/featured_staff_cubit/featured_staff_state.dart';
import 'package:project2/screens/staff/presentation/views/staff_details_view.dart';

import 'staffs_list_view_item.dart';

class StaffsListView extends StatelessWidget {
  const StaffsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedStaffCubit, FeaturedStaffState>(
      builder: (context, state) {
        if (state is FeaturedStaffSuccess) {
          return Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.allStaff.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  print('nav!!!!!!!!!!!!!!!!!!!');
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StaffDetailsView(id: state.allStaff[index].id),),
                  );
                },
                child: StaffsListViewItem(
                  image: state.allStaff[index].imagePath!,
                  rank: (index + 1).toString(),
                  name: state.allStaff[index].name,
                  description: state.allStaff[index].role,
                  date: state.allStaff[index].createdAt,
                ),
              ),
            ),
          );
        } else if (state is FeaturedStaffFailure) {
          return Text(state.errorMessage);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
