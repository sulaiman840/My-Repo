import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/screens/Manager_Screens/Request_Managmenet_Screen/traner_details_manager_screen.dart';
import 'package:project2/screens/Secertary_Screens/Trainer/trainer_details.dart';

import '../../../Bloc/manager/pending_course_cubit.dart';
import '../../../Bloc/manager/pending_course_state.dart';
import '../../../Bloc/manager/pending_beneficiary_cubit.dart';
import '../../../Bloc/manager/pending_beneficiary_state.dart';
import '../../../Bloc/manager/pending_trainer_cubit.dart';
import '../../../Bloc/manager/pending_trainer_state.dart';
import '../../../core/utils/color_manager.dart';
import 'beneficiary_detail_manager_screen.dart';
import 'course_detail_manager_screen.dart';

class RequestManagementScreen extends StatelessWidget {
  const RequestManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.bc1,
          centerTitle: true,
          title: Text(
            'Request Management',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorManager.bc4,
            ),
          ),
          bottom: TabBar(
            indicatorColor: ColorManager.bc4,
            labelColor: ColorManager.bc4,
            unselectedLabelColor: ColorManager.bc5,
            tabs: [
              Tab(text: 'Courses'),
              Tab(text: 'Beneficiaries'),
              Tab(text: 'Trainers'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildCourseTab(context),
            _buildBeneficiaryTab(context),
            _buildTrainersTab(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseTab(BuildContext context) {
    context.read<PendingRequestCubit>().fetchPendingRequests();
    return BlocBuilder<PendingRequestCubit, PendingRequestState>(
      builder: (context, state) {
        if (state is PendingRequestLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PendingRequestLoaded) {
          if (state.pendingRequests.isEmpty) {
            return Center(child: Text('No pending courses available.', style: TextStyle(fontSize: 16)));
          }
          return ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: state.pendingRequests.length,
            itemBuilder: (context, index) {
              final pendingRequest = state.pendingRequests[index];
              final course = pendingRequest.requestPending;
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.book, color: ColorManager.blue, size: 30),
                  title: Text(course.nameCourse, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Text('Period: ${course.coursePeriod}', style: TextStyle(color: Colors.grey[700])),
                      Text('Status: ${pendingRequest.status}', style: TextStyle(color: Colors.grey[700])),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseDetailManagerScreen(pendingRequest: pendingRequest),
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else if (state is PendingRequestError) {
          return Center(child: Text(state.message, style: TextStyle(fontSize: 16, color: Colors.red)));
        } else {
          return Container();
        }
      },
    );
  }
  Widget _buildBeneficiaryTab(BuildContext context) {
    context.read<PendingBeneficiaryCubit>().fetchPendingRequests();
    return BlocBuilder<PendingBeneficiaryCubit, PendingBeneficiaryState>(
      builder: (context, state) {
        if (state is PendingBeneficiaryLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PendingBeneficiaryLoaded) {
          if (state.pendingRequests.isEmpty) {
            return Center(child: Text('No pending beneficiaries available.', style: TextStyle(fontSize: 16)));
          }
          return ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: state.pendingRequests.length,
            itemBuilder: (context, index) {
              final pendingRequest = state.pendingRequests[index];
              final beneficiary = pendingRequest.requsetPending;
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.person, color: ColorManager.blue, size: 30),
                  title: Text(beneficiary?.name ?? 'N/A', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Text('Email: ${beneficiary?.email ?? 'N/A'}', style: TextStyle(color: Colors.grey[700])),
                      Text('Status: ${pendingRequest.status}', style: TextStyle(color: Colors.grey[700])),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BeneficiaryDetailManagerScreen(pendingRequest: pendingRequest),
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else if (state is PendingBeneficiaryError) {
          return Center(child: Text(state.message, style: TextStyle(fontSize: 16, color: Colors.red)));
        } else {
          return Container();
        }
      },
    );
  }


  Widget _buildTrainersTab(BuildContext context) {
    context.read<PendingTrainerCubit>().fetchPendingTrainers();
    return BlocBuilder<PendingTrainerCubit, PendingTrainerState>(
      builder: (context, state) {
        if (state is PendingTrainerLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PendingTrainerLoaded) {
          if (state.pendingTrainers.isEmpty) {
            return Center(child: Text('No pending trainers available.', style: TextStyle(fontSize: 16)));
          }
          return ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: state.pendingTrainers.length,
            itemBuilder: (context, index) {
              final pendingTrainers = state.pendingTrainers[index];
              final trainers = pendingTrainers;
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.person, color: ColorManager.blue, size: 30),
                  title: Text(trainers?.name ?? 'N/A', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Text('Email: ${trainers?.email ?? 'N/A'}', style: TextStyle(color: Colors.grey[700])),
                      Text('Status: ${trainers.status}', style: TextStyle(color: Colors.grey[700])),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TranerDetailsManagerScreen(pendingTrainer: pendingTrainers),
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else if (state is PendingTrainerError) {
          return Center(child: Text(state.message, style: TextStyle(fontSize: 16, color: Colors.red)));
        } else {
          return Container();
        }
      },
    );
  }
}
