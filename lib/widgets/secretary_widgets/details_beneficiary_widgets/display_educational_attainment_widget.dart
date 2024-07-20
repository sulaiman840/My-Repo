import 'package:flutter/cupertino.dart';

import '../../../core/utils/color_manager.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';

class DisplayEducationalAttainmentWidget extends StatelessWidget {
  final List<EducationalAttainment> educationalAttainments;

  DisplayEducationalAttainmentWidget({required this.educationalAttainments});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: educationalAttainments.map((attainment) => _buildEducationalAttainmentItem(context, attainment)).toList(),
    );
  }

  Widget _buildEducationalAttainmentItem(BuildContext context, EducationalAttainment attainment) {
    return Container(
      width: MediaQuery.of(context).size.width / 3 - 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(attainment.educationalAttainmentLevel ?? '', style: TextStyle(fontSize: 16, color: ColorManager.bc4)),
          Text(attainment.specialization ?? '', style: TextStyle(fontSize: 16, color: ColorManager.bc4)),
          Text(attainment.certificate ?? '', style: TextStyle(fontSize: 16, color: ColorManager.bc4)),
          Text(attainment.graduationRate ?? '', style: TextStyle(fontSize: 16, color: ColorManager.bc4)),
          Text(attainment.academicYear ?? '', style: TextStyle(fontSize: 16, color: ColorManager.bc4)),
        ],
      ),
    );
  }
}
