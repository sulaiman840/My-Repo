import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/pending_course_model.dart';
import '../../core/utils/color_manager.dart';
import '../../widgets/general_widgets/common_scaffold.dart';
import '../../Bloc/secertary/course/pending_course_cubit.dart';

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
                  child: Text('Approve', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
                SizedBox(width: 20,),
                ElevatedButton(
                  onPressed: () => _rejectRequest(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('Reject', style: TextStyle(fontSize: 16, color: Colors.white)),
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
                    _buildDetailItem(Icons.book, 'Course Name', course.nameCourse),
                    _buildDetailItem(Icons.schedule, 'Period', course.coursePeriod),
                    _buildDetailItem(Icons.category, 'Type', course.type),
                    _buildDetailItem(Icons.info_outline, 'Status', course.courseStatus),
                    _buildDetailItem(Icons.star, 'Specialty', course.specialty),
                    _buildDetailItem(Icons.description, 'Description', course.description),
                    _buildDetailItem(Icons.assignment, 'Request Status', pendingRequest.status),
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
    Navigator.pop(context);
  }

  void _rejectRequest(BuildContext context) {
    context.read<PendingRequestCubit>().rejectRequest(pendingRequest.id);
    Navigator.pop(context);
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
