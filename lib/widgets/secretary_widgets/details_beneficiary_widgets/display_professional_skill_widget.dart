import 'package:flutter/cupertino.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/color_manager.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';

class DisplayProfessionalSkillWidget extends StatelessWidget {
  final List<ProfessionalSkill> professionalSkills;

  DisplayProfessionalSkillWidget({required this.professionalSkills});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: professionalSkills.map((skill) => _buildProfessionalSkillItem(context, skill)).toList(),
    );
  }

  Widget _buildProfessionalSkillItem(BuildContext context, ProfessionalSkill skill) {
    return Container(
      width: MediaQuery.of(context).size.width / 3 - 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(skill.jobTitle ?? '', style: TextStyle(fontSize: 16, color: ColorManager.bc4)),
          Text('${AppLocalizations.of(context).translate('start')}: ${skill.start}', style: TextStyle(fontSize: 16, color: ColorManager.bc4)),
          Text('${AppLocalizations.of(context).translate('end')}: ${skill.end}', style: TextStyle(fontSize: 16, color: ColorManager.bc4)),
          Text(skill.jobTasks ?? '', style: TextStyle(fontSize: 16, color: ColorManager.bc4)),
        ],
      ),
    );
  }
}
