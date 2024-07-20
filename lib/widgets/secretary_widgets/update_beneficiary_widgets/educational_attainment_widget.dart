import 'package:flutter/material.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';

class EducationalAttainmentWidget extends StatelessWidget {
  final List<EducationalAttainment> educationalAttainments;

  EducationalAttainmentWidget({required this.educationalAttainments});

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
              'Educational Attainments',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: educationalAttainments.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    TextFormField(
                      initialValue: educationalAttainments[index].specialization,
                      decoration: InputDecoration(labelText: 'Specialization'),
                      onSaved: (value) {
                        educationalAttainments[index].specialization = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: educationalAttainments[index].certificate,
                      decoration: InputDecoration(labelText: 'Certificate'),
                      onSaved: (value) {
                        educationalAttainments[index].certificate = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: educationalAttainments[index].graduationRate,
                      decoration: InputDecoration(labelText: 'Graduation Rate'),
                      onSaved: (value) {
                        educationalAttainments[index].graduationRate = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: educationalAttainments[index].academicYear,
                      decoration: InputDecoration(labelText: 'Academic Year'),
                      onSaved: (value) {
                        educationalAttainments[index].academicYear = value!;
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
