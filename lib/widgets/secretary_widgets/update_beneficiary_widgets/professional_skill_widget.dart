import 'package:flutter/material.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';

class ProfessionalSkillWidget extends StatelessWidget {
  final List<ProfessionalSkill> professionalSkills;

  ProfessionalSkillWidget({required this.professionalSkills});

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
              'Professional Skills',
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
                      decoration: InputDecoration(labelText: 'Job Title'),
                      onSaved: (value) {
                        professionalSkills[index].jobTitle = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: professionalSkills[index].start,
                      decoration: InputDecoration(labelText: 'Start Date'),
                      onSaved: (value) {
                        professionalSkills[index].start = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: professionalSkills[index].end,
                      decoration: InputDecoration(labelText: 'End Date'),
                      onSaved: (value) {
                        professionalSkills[index].end = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: professionalSkills[index].jobTasks,
                      decoration: InputDecoration(labelText: 'Job Tasks'),
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
