import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../Bloc/manager/pending_course_cubit.dart';
import '../../../Bloc/manager/pending_course_state.dart';
import '../../../Bloc/manager/pending_beneficiary_cubit.dart';
import '../../../Bloc/manager/pending_beneficiary_state.dart';
import '../../../Bloc/manager/pending_trainer_cubit.dart';
import '../../../Bloc/manager/pending_trainer_state.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/color_manager.dart';
import '../../../models/Pending Model/pending_beneficiary_request_model.dart';
import '../warehouse/request_manager/presentation/view/request_category_view.dart';
import '../warehouse/request_manager/presentation/view/request_item_view.dart';

class RequestManagementScreen extends StatefulWidget {
  const RequestManagementScreen({super.key});

  @override
  _RequestManagementScreenState createState() =>
      _RequestManagementScreenState();
}

class _RequestManagementScreenState extends State<RequestManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 5,
      vsync: this,
    );
  }

  void _navigateToEditScreen(
      BuildContext context, DataRequest? beneficiary) async {
    context.go('/beneficiary_edit_manager', extra: {
      'beneficiary': beneficiary,
      'callback': () {
        print("Returned from update screen");
        //   _fetchBeneficiaries();
      },
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.bc1,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate('request_management'),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorManager.bc4,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: ColorManager.bc4,
          labelColor: ColorManager.bc4,
          unselectedLabelColor: ColorManager.bc5,
          tabs: [
            Tab(text: AppLocalizations.of(context).translate('courses'),),
            Tab(text: AppLocalizations.of(context).translate('beneficiaries'),),
            Tab(text: AppLocalizations.of(context).translate('trainers'),),
            Tab(text: AppLocalizations.of(context).translate('category'),),
            Tab(text: AppLocalizations.of(context).translate('items'),),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCourseTab(context),
          _buildBeneficiaryTab(context),
          _buildTrainersTab(context),
          const RequestCategoryView(),
          const RequestItemView(),
        ],
      ),
    );
  }

  Widget _buildCourseTab(BuildContext context) {
    context.read<PendingRequestCubit>().fetchPendingRequests();
    return BlocBuilder<PendingRequestCubit, PendingRequestState>(
      builder: (context, state) {
        if (state is PendingRequestLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PendingRequestLoaded) {
          if (state.pendingRequests.isEmpty) {
            return Center(
                child: Text(AppLocalizations.of(context).translate('no_pending_courses_available'),
                    style: TextStyle(fontSize: 16)));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8),
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
                  leading: const Icon(Icons.book,
                      color: ColorManager.blue, size: 30),
                  title: Text(course.nameCourse,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('${AppLocalizations.of(context).translate('period')}: ${course.coursePeriod}',
                          style: TextStyle(color: Colors.grey[700])),
                      Text('${AppLocalizations.of(context).translate('status')}: ${pendingRequest.status}',
                          style: TextStyle(color: Colors.grey[700])),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      color: Colors.grey, size: 16),
                  onTap: () {
                    context.go('/course_detail_manager/${pendingRequest.id}',
                        extra: pendingRequest);
                  },
                ),
              );
            },
          );
        } else if (state is PendingRequestError) {
          return Center(
              child: Text(state.message,
                  style: const TextStyle(fontSize: 16, color: Colors.red)));
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
          return const Center(child: CircularProgressIndicator());
        } else if (state is PendingBeneficiaryLoaded) {
          if (state.pendingRequests.isEmpty) {
            return Center(
                child: Text(AppLocalizations.of(context).translate('no_pending_beneficiaries_available'),
                    style: TextStyle(fontSize: 16)));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8),
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
                  leading: const Icon(Icons.person,
                      color: ColorManager.blue, size: 30),
                  title: Text(beneficiary?.name ?? 'N/A',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('${AppLocalizations.of(context).translate('email')}: ${beneficiary?.email ?? 'N/A'}',
                          style: TextStyle(color: Colors.grey[700])),
                      Text('${AppLocalizations.of(context).translate('status')}: ${pendingRequest.status}',
                          style: TextStyle(color: Colors.grey[700])),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          _navigateToEditScreen(context, pendingRequest);

                        },
                      ),

                    ],
                  ),
                  onTap: () {
                    context.go(
                        '/beneficiary_detail_manager/${pendingRequest.id}',
                        extra: pendingRequest);
                  },
                ),
              );
            },
          );
        } else if (state is PendingBeneficiaryError) {
          return Center(
              child: Text(state.message,
                  style: const TextStyle(fontSize: 16, color: Colors.red)));
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
          return const Center(child: CircularProgressIndicator());
        } else if (state is PendingTrainerLoaded) {
          if (state.pendingTrainers.isEmpty) {
            return Center(
                child: Text(AppLocalizations.of(context).translate('no_pending_trainers_available'),
                    style: TextStyle(fontSize: 16)));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: state.pendingTrainers.length,
            itemBuilder: (context, index) {
              final pendingTrainer = state.pendingTrainers[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: const Icon(Icons.person,
                      color: ColorManager.blue, size: 30),
                  title: Text(pendingTrainer?.name ?? 'N/A',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('${AppLocalizations.of(context).translate('email')}: ${pendingTrainer?.email ?? 'N/A'}',
                          style: TextStyle(color: Colors.grey[700])),
                      Text('${AppLocalizations.of(context).translate('status')}: ${pendingTrainer.status}',
                          style: TextStyle(color: Colors.grey[700])),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      color: Colors.grey, size: 16),
                  onTap: () {
                    context.go('/trainer_detail_manager/${pendingTrainer.id}',
                        extra: pendingTrainer);
                  },
                ),
              );
            },
          );
        } else if (state is PendingTrainerError) {
          return Center(
              child: Text(state.message,
                  style: const TextStyle(fontSize: 16, color: Colors.red)));
        } else {
          return Container();
        }
      },
    );
  }
}
