import 'package:flutter/cupertino.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../models/Secertary Model/beneficiary_model.dart';
import '../../../models/Pending Model/pending_beneficiary_request_model.dart';

class DisplayDisabilityManagerWidget extends StatelessWidget {
  final List<Disabilities> disabilities;
  final String title;

  DisplayDisabilityManagerWidget({required this.disabilities, required this.title});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: disabilities.map((disability) => _buildDisabilityItem(context, disability)).toList(),
    );
  }

  Widget _buildDisabilityItem(BuildContext context, Disabilities disability) {
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
