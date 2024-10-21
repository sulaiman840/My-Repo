import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
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
              AppLocalizations.of(context).translate('educational_attainments'),
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
                      decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('specialization')),
                      onSaved: (value) {
                        educationalAttainments[index].specialization = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: educationalAttainments[index].certificate,
                      decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('certificate')),
                      onSaved: (value) {
                        educationalAttainments[index].certificate = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: educationalAttainments[index].graduationRate,
                      decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('graduation_rate')),
                      onSaved: (value) {
                        educationalAttainments[index].graduationRate = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: educationalAttainments[index].academicYear,
                      decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('academic_year')),
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
