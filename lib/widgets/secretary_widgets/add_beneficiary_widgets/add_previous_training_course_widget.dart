import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/color_manager.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';

class AddPreviousTrainingCourseWidget extends StatelessWidget {
  final List<PreviousTrainingCourse> previousTrainingCourses;
  final ValueChanged<List<PreviousTrainingCourse>> onChanged;

  AddPreviousTrainingCourseWidget({required this.previousTrainingCourses, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text('Previous Training Courses', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorManager.bc5)),
        ...previousTrainingCourses.map((course) => _buildPreviousTrainingCourseItem(context, course)).toList(),
        TextButton(
          onPressed: () {
            previousTrainingCourses.add(PreviousTrainingCourse());
            onChanged(previousTrainingCourses);
          },
          child: Text('Add Previous Training Course'),
        ),
      ],
    );
  }

  Widget _buildPreviousTrainingCourseItem(BuildContext context, PreviousTrainingCourse course) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          TextFormField(
            initialValue: course.certificateAndType,
            decoration: InputDecoration(
              labelText: 'Certificate and Type',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            onChanged: (value) {
              course.certificateAndType = value;
              onChanged(previousTrainingCourses);
            },
          ),
          SizedBox(height: 8),
          TextFormField(
            initialValue: course.executingAgency,
            decoration: InputDecoration(
              labelText: 'Executing Agency',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            onChanged: (value) {
              course.executingAgency = value;
              onChanged(previousTrainingCourses);
            },
          ),
          SizedBox(height: 8),
          TextFormField(
            initialValue: course.dateExecute,
            decoration: InputDecoration(
              labelText: 'Date Execute',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            onChanged: (value) {
              course.dateExecute = value;
              onChanged(previousTrainingCourses);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              previousTrainingCourses.remove(course);
              onChanged(previousTrainingCourses);
            },
          ),
        ],
      ),
    );
  }
}
