import 'package:flutter/material.dart';
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
              'Previous Training Courses',
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
                      decoration: InputDecoration(labelText: 'Certificate and Type'),
                      onSaved: (value) {
                        previousTrainingCourses[index].certificateAndType = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: previousTrainingCourses[index].executingAgency,
                      decoration: InputDecoration(labelText: 'Executing Agency'),
                      onSaved: (value) {
                        previousTrainingCourses[index].executingAgency = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: previousTrainingCourses[index].dateExecute,
                      decoration: InputDecoration(labelText: 'Date of Execution'),
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
