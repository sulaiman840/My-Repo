import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/color_manager.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';

class AddProfessionalSkillWidget extends StatelessWidget {
  final List<ProfessionalSkill> professionalSkills;
  final ValueChanged<List<ProfessionalSkill>> onChanged;

  AddProfessionalSkillWidget({required this.professionalSkills, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text('Professional Skills', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorManager.bc5)),
        ...professionalSkills.map((skill) => _buildProfessionalSkillItem(context, skill)).toList(),
        TextButton(
          onPressed: () {
            professionalSkills.add(ProfessionalSkill());
            onChanged(professionalSkills);
          },
          child: Text('Add Professional Skill'),
        ),
      ],
    );
  }

  Widget _buildProfessionalSkillItem(BuildContext context, ProfessionalSkill skill) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          TextFormField(
            initialValue: skill.jobTitle,
            decoration: InputDecoration(
              labelText: 'Job Title',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            onChanged: (value) {
              skill.jobTitle = value;
              onChanged(professionalSkills);
            },
          ),
          SizedBox(height: 8),
          TextFormField(
            initialValue: skill.start,
            decoration: InputDecoration(
              labelText: 'Start Date',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            onChanged: (value) {
              skill.start = value;
              onChanged(professionalSkills);
            },
          ),
          SizedBox(height: 8),
          TextFormField(
            initialValue: skill.end,
            decoration: InputDecoration(
              labelText: 'End Date',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            onChanged: (value) {
              skill.end = value;
              onChanged(professionalSkills);
            },
          ),
          SizedBox(height: 8),
          TextFormField(
            initialValue: skill.jobTasks,
            decoration: InputDecoration(
              labelText: 'Job Tasks',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            onChanged: (value) {
              skill.jobTasks = value;
              onChanged(professionalSkills);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              professionalSkills.remove(skill);
              onChanged(professionalSkills);
            },
          ),
        ],
      ),
    );
  }
}
