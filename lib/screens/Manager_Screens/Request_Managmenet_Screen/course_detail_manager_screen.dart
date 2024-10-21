import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../models/Pending Model/pending_course_model.dart';
import '../../../core/utils/color_manager.dart';
import '../../../widgets/general_widgets/common_scaffold.dart';
import '../../../Bloc/manager/pending_course_cubit.dart';

class CourseDetailManagerScreen extends StatelessWidget {
  final PendingRequest pendingRequest;

  const CourseDetailManagerScreen({Key? key, required this.pendingRequest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final course = pendingRequest.requestPending;

    return CommonScaffold(
      title: course.nameCourse,
      scaffoldKey: GlobalKey<ScaffoldState>(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () => _approveRequest(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(AppLocalizations.of(context).translate('approve'), style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
                SizedBox(width: 20,),
                ElevatedButton(
                  onPressed: () => _rejectRequest(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(AppLocalizations.of(context).translate('reject'), style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailItem(Icons.book, AppLocalizations.of(context).translate('course_name'), course.nameCourse),
                    _buildDetailItem(Icons.schedule, AppLocalizations.of(context).translate('period'), course.coursePeriod.toString()),
                    _buildDetailItem(Icons.category, AppLocalizations.of(context).translate('type'), course.type),
                    // _buildDetailItem(Icons.timeline, 'Session Duration', course.sessionDuration?.toString() ?? 'N/A'),
          //          _buildDetailItem(Icons.timeline, 'Session Duration', course.sessionDuration.toString()),

                    _buildDetailItem(Icons.info_outline, AppLocalizations.of(context).translate('status'), course.courseStatus),
                    _buildDetailItem(Icons.star, AppLocalizations.of(context).translate('specialty'), course.specialty),
                    _buildDetailItem(Icons.description, AppLocalizations.of(context).translate('description'), course.description),
                    _buildDetailItem(Icons.assignment, AppLocalizations.of(context).translate('request_status'), pendingRequest.status),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _approveRequest(BuildContext context) {
    context.read<PendingRequestCubit>().approveRequest(pendingRequest.id);
    context.go('/manager_home?tab=3');
  }

  void _rejectRequest(BuildContext context) {
    context.read<PendingRequestCubit>().rejectRequest(pendingRequest.id);
    context.go('/manager_home?tab=3');
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue, size: 24),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: ColorManager.bc5)),
                SizedBox(height: 4),
                Text(value, style: TextStyle(fontSize: 16, color: ColorManager.bc4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
