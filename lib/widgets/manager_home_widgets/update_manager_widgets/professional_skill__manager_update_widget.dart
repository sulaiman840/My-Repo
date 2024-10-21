import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';
import '../../../models/Pending Model/pending_beneficiary_request_model.dart';

class ProfessionalSkillManagerUpdateWidget extends StatelessWidget {
  final List<ProfessionalSkills> professionalSkills;

  ProfessionalSkillManagerUpdateWidget({required this.professionalSkills});

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
              AppLocalizations.of(context).translate('professional_skills'),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: professionalSkills.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    TextFormField(
                      initialValue: professionalSkills[index].jobTitle,
                      decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('job_title')),
                      onSaved: (value) {
                        professionalSkills[index].jobTitle = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: professionalSkills[index].start,
                      decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('start_date')),
                      onSaved: (value) {
                        professionalSkills[index].start = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: professionalSkills[index].end,
                      decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('end_date')),
                      onSaved: (value) {
                        professionalSkills[index].end = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: professionalSkills[index].jobTasks,
                      decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('job_tasks')),
                      onSaved: (value) {
                        professionalSkills[index].jobTasks = value!;
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
