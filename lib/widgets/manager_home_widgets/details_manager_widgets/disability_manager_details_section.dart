import 'package:flutter/cupertino.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../models/Secertary Model/beneficiary_model.dart';
import '../../../models/Pending Model/pending_beneficiary_request_model.dart';
import 'display_disability_manager_widget.dart';


class DisabilityManagerDetailsSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Disabilities>? disabilities;

  DisabilityManagerDetailsSection({required this.icon, required this.title, required this.disabilities});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Row(
          children: [
            Icon(icon, color: ColorManager.blue, size: 24),
            SizedBox(width: 8),
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorManager.bc5)),
          ],
        ),
        SizedBox(height: 8),
        DisplayDisabilityManagerWidget(disabilities: disabilities ?? [], title: title),
      ],
    );
  }
}
