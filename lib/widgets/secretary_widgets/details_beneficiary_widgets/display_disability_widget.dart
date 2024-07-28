import 'package:flutter/cupertino.dart';

import '../../../core/utils/color_manager.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';

class DisplayDisabilityWidget extends StatelessWidget {
  final List<Disability> disabilities;
  final String title;

  DisplayDisabilityWidget({required this.disabilities, required this.title});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: disabilities.map((disability) => _buildDisabilityItem(context, disability)).toList(),
    );
  }

  Widget _buildDisabilityItem(BuildContext context, Disability disability) {
    return Container(
      width: MediaQuery.of(context).size.width / 3 - 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(disability.nameDisability ?? '', style: TextStyle(fontSize: 16, color: ColorManager.bc4)),
          if (disability.rateDisability != null)
            Text('Rate: ${disability.rateDisability}', style: TextStyle(fontSize: 16, color: ColorManager.bc4)),
        ],
      ),
    );
  }
}
