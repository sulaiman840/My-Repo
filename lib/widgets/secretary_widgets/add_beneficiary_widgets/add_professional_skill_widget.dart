import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/color_manager.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';

class AddProfessionalSkillWidget extends StatefulWidget {
  final ValueNotifier<List<ProfessionalSkill>> professionalSkillsNotifier;

  AddProfessionalSkillWidget({
    required List<ProfessionalSkill> professionalSkills,
  }) : professionalSkillsNotifier = ValueNotifier(professionalSkills);

  @override
  _AddProfessionalSkillWidgetState createState() => _AddProfessionalSkillWidgetState();
}

class _AddProfessionalSkillWidgetState extends State<AddProfessionalSkillWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<ProfessionalSkill>>(
      valueListenable: widget.professionalSkillsNotifier,
      builder: (context, professionalSkills, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              AppLocalizations.of(context).translate('professional_skills'),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorManager.bc5,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: professionalSkills.length,
              itemBuilder: (context, index) {
                return _buildProfessionalSkillItem(context, professionalSkills[index]);
              },
            ),
            TextButton(
              onPressed: () {
                final newSkill = ProfessionalSkill();
                widget.professionalSkillsNotifier.value = [
                  ...professionalSkills,
                  newSkill,
                ];
              },
              child: Text(AppLocalizations.of(context).translate('add_professional_skill')),
            ),
            if (professionalSkills.isEmpty)
              Text(
                AppLocalizations.of(context).translate('no_professional_skills_added'),
                style: TextStyle(fontSize: 16),
              ),
          ],
        );
      },
    );
  }

  Widget _buildProfessionalSkillItem(BuildContext context, ProfessionalSkill skill) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          _buildTextFormField(
            context,
            label: AppLocalizations.of(context).translate('job_title'),
            initialValue: skill.jobTitle ?? '',
            onChanged: (value) {
              skill.jobTitle = value;
            },
          ),
          SizedBox(height: 8),
          _buildTextFormField(
            context,
            label: AppLocalizations.of(context).translate('start_date'),
            initialValue: skill.start ?? '',
            onChanged: (value) {
              skill.start = value;
            },
          ),
          SizedBox(height: 8),
          _buildTextFormField(
            context,
            label: AppLocalizations.of(context).translate('end_date'),
            initialValue: skill.end ?? '',
            onChanged: (value) {
              skill.end = value;
            },
          ),
          SizedBox(height: 8),
          _buildTextFormField(
            context,
            label: AppLocalizations.of(context).translate('job_tasks'),
            initialValue: skill.jobTasks ?? '',
            onChanged: (value) {
              skill.jobTasks = value;
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              widget.professionalSkillsNotifier.value = [
                ...widget.professionalSkillsNotifier.value..remove(skill),
              ];
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField(BuildContext context,
      {required String label, required String initialValue, required ValueChanged<String> onChanged}) {
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
