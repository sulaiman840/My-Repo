import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';
import '../../../models/Pending Model/pending_beneficiary_request_model.dart';

class PreviousTrainingCourseManagerUpdateWidget extends StatelessWidget {
  final List<PreviousTrainingCourses> previousTrainingCourses;

  PreviousTrainingCourseManagerUpdateWidget({required this.previousTrainingCourses});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).translate('previous_training_courses'),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: previousTrainingCourses.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    TextFormField(
                      initialValue: previousTrainingCourses[index].certificateAndType,
                      decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('certificate_and_type')),
                      onSaved: (value) {
                        previousTrainingCourses[index].certificateAndType = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: previousTrainingCourses[index].executingAgency,
                      decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('executing_agency')),
                      onSaved: (value) {
                        previousTrainingCourses[index].executingAgency = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: previousTrainingCourses[index].dateExecute,
                      decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('date_of_execution')),
                      onSaved: (value) {
                        previousTrainingCourses[index].dateExecute = value!;
                      },
                    ),
                    SizedBox(height: 10),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
