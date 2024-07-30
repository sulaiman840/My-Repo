import 'package:flutter/cupertino.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../models/Pending Model/pending_beneficiary_request_model.dart';


class DisplayProfessionalSkillManagerWidget extends StatelessWidget {
  final List<ProfessionalSkills> professionalSkills;

  DisplayProfessionalSkillManagerWidget({required this.professionalSkills});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: professionalSkills.map((skill) => _buildProfessionalSkillItem(context, skill)).toList(),
    );
  }

  Widget _buildProfessionalSkillItem(BuildContext context, ProfessionalSkills skill) {
    return Container(
      width: MediaQuery.of(context).size.width / 3 - 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(skill.jobTitle ?? '', style: TextStyle(fontSize: 16, color: ColorManager.bc4)),
          Text('Start: ${skill.start}', style: TextStyle(fontSize: 16, color: ColorManager.bc4)),
          Text('End: ${skill.end}', style: TextStyle(fontSize: 16, color: ColorManager.bc4)),
          Text(skill.jobTasks ?? '', style: TextStyle(fontSize: 16, color: ColorManager.bc4)),
        ],
      ),
    );
  }
}
