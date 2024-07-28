import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc/secertary/course/course_detail_cubit.dart';
import '../../../Bloc/secertary/course/course_detail_state.dart';
import '../../../core/utils/color_manager.dart';
import '../../../widgets/general_widgets/common_scaffold.dart';

class CourseDetailScreen extends StatefulWidget {
  final int courseId;

  const CourseDetailScreen({required this.courseId, Key? key}) : super(key: key);

  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CourseDetailCubit>().fetchCourseDetail(widget.courseId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseDetailCubit, CourseDetailState>(
      builder: (context, state) {
        if (state is CourseDetailLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CourseDetailLoaded) {
          final course = state.course;
          return CommonScaffold(
            title: 'Course Detail',
            scaffoldKey: GlobalKey<ScaffoldState>(),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Card(
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

                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is CourseDetailError) {
          return Center(child: Text(state.message));
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: ColorManager.blue, size: 24),
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
