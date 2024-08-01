import 'package:flutter/cupertino.dart';

import '../../../../core/utils/color_manager.dart';

import '../../../models/Pending Model/pending_beneficiary_request_model.dart';

class DisplayEducationalManagerAttainmentWidget extends StatelessWidget {
  final List<EducationalAttainments> educationalAttainments;

  DisplayEducationalManagerAttainmentWidget({required this.educationalAttainments});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: educationalAttainments.map((attainment) => _buildEducationalAttainmentItem(context, attainment)).toList(),
    );
  }

  Widget _buildEducationalAttainmentItem(BuildContext context, EducationalAttainments attainment) {
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
