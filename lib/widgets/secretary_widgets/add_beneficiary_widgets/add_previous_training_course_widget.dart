import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/color_manager.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';

class AddPreviousTrainingCourseWidget extends StatefulWidget {
  final ValueNotifier<List<PreviousTrainingCourse>> previousTrainingCoursesNotifier;

  AddPreviousTrainingCourseWidget({
    required List<PreviousTrainingCourse> previousTrainingCourses,
  }) : previousTrainingCoursesNotifier = ValueNotifier(previousTrainingCourses);

  @override
  _AddPreviousTrainingCourseWidgetState createState() => _AddPreviousTrainingCourseWidgetState();
}

class _AddPreviousTrainingCourseWidgetState extends State<AddPreviousTrainingCourseWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<PreviousTrainingCourse>>(
      valueListenable: widget.previousTrainingCoursesNotifier,
      builder: (context, previousTrainingCourses, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              AppLocalizations.of(context).translate('previous_training_courses'),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorManager.bc5),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: previousTrainingCourses.length,
              itemBuilder: (context, index) {
                return _buildPreviousTrainingCourseItem(context, previousTrainingCourses[index]);
              },
            ),
            TextButton(
              onPressed: () {
                final newCourse = PreviousTrainingCourse();
                widget.previousTrainingCoursesNotifier.value = [
                  ...previousTrainingCourses,
                  newCourse,
                ];
              },
              child: Text(AppLocalizations.of(context).translate('add_previous_training_course')),
            ),
            if (previousTrainingCourses.isEmpty)
              Text(
                AppLocalizations.of(context).translate('no_previous_training_courses_added'),
                style: TextStyle(fontSize: 16),
              ),
          ],
        );
      },
    );
  }

  Widget _buildPreviousTrainingCourseItem(BuildContext context, PreviousTrainingCourse course) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          _buildTextFormField(
            context,
            label: AppLocalizations.of(context).translate('certificate_and_type'),
            initialValue: course.certificateAndType ?? '',
            onChanged: (value) {
              course.certificateAndType = value;
            },
          ),
          SizedBox(height: 8),
          _buildTextFormField(
            context,
            label: AppLocalizations.of(context).translate('executing_agency'),
            initialValue: course.executingAgency ?? '',
            onChanged: (value) {
              course.executingAgency = value;
            },
          ),
          SizedBox(height: 8),
          _buildTextFormField(
            context,
            label: AppLocalizations.of(context).translate('date_execute'),
            initialValue: course.dateExecute ?? '',
            onChanged: (value) {
              course.dateExecute = value;
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              widget.previousTrainingCoursesNotifier.value = [
                ...widget.previousTrainingCoursesNotifier.value..remove(course),
              ];
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField(BuildContext context,
      {required String label,
        required String initialValue,
        required ValueChanged<String> onChanged}) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      onChanged: onChanged,
    );
  }
}
