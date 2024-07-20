import 'package:flutter/cupertino.dart';

import '../../../core/utils/color_manager.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';

class DisplayPreviousTrainingCourseWidget extends StatelessWidget {
  final List<PreviousTrainingCourse> previousTrainingCourses;

  DisplayPreviousTrainingCourseWidget({required this.previousTrainingCourses});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: previousTrainingCourses.map((course) => _buildPreviousTrainingCourseItem(context, course)).toList(),
    );
  }

  Widget _buildPreviousTrainingCourseItem(BuildContext context, PreviousTrainingCourse course) {
    return Container(
      width: MediaQuery.of(context).size.width / 3 - 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(course.certificateAndType ?? '', style: TextStyle(fontSize: 16, color: ColorManager.bc4)),
          Text(course.executingAgency ?? '', style: TextStyle(fontSize: 16, color: ColorManager.bc4)),
          Text(course.dateExecute ?? '', style: TextStyle(fontSize: 16, color: ColorManager.bc4)),
        ],
      ),
    );
  }
}
