import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/Pending Model/pending_beneficiary_request_model.dart';
import '../../secretary_widgets/details_beneficiary_widgets/detail_item_widget.dart';

class DetailItemsList extends StatelessWidget {
  final RequsetPending beneficiary;

  const DetailItemsList({Key? key, required this.beneficiary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: [
        DetailItem(icon: Icons.confirmation_number, label: 'Serial Number', value: beneficiary.serialNumber.toString() ?? 'N/A'),
        DetailItem(icon: Icons.date_range, label: 'Date', value: beneficiary.date ?? 'N/A'),
        DetailItem(icon: Icons.location_city, label: 'Province', value: beneficiary.province ?? 'N/A'),
        DetailItem(icon: Icons.person, label: 'Name', value: beneficiary.name ?? 'N/A'),
        DetailItem(icon: Icons.person_outline, label: 'Father Name', value: beneficiary.fatherName ?? 'N/A'),
        DetailItem(icon: Icons.person_outline, label: 'Mother Name', value: beneficiary.motherName ?? 'N/A'),
        DetailItem(icon: Icons.wc, label: 'Gender', value: beneficiary.gender ?? 'N/A'),
        DetailItem(icon: Icons.cake, label: 'Date of Birth', value: beneficiary.dateOfBirth ?? 'N/A'),
        DetailItem(icon: Icons.notes, label: 'Notes', value: beneficiary.nots ?? 'N/A'),
        DetailItem(icon: Icons.family_restroom, label: 'Marital Status', value: beneficiary.maritalStatus ?? 'N/A'),
        DetailItem(icon: Icons.accessibility, label: 'Need Attendant', value: beneficiary.needAttendant ?? 'N/A'),
        DetailItem(icon: Icons.group, label: 'Number of Family Members', value: beneficiary.numberFamilyMember.toString() ?? 'N/A'),
        DetailItem(icon: Icons.group_off, label: 'Losing Breadwinner', value: beneficiary.losingBreadwinner ?? 'N/A'),
        DetailItem(icon: Icons.map, label: 'Governorate', value: beneficiary.governorate ?? 'N/A'),
        DetailItem(icon: Icons.home, label: 'Address', value: beneficiary.address ?? 'N/A'),
        DetailItem(icon: Icons.email, label: 'Email', value: beneficiary.email ?? 'N/A'),
        DetailItem(icon: Icons.phone, label: 'Number Line', value: beneficiary.numberline ?? 'N/A'),
  //      DetailItem(icon: Icons.phone_android, label: 'Number Phone', value: beneficiary.numberPhone.toString() ?? 'N/A'),
        DetailItem(icon: Icons.perm_identity, label: 'Number ID', value: beneficiary.numberId ?? 'N/A'),
        DetailItem(icon: Icons.computer, label: 'Computer Driving', value: beneficiary.computerDriving ?? 'N/A'),
        DetailItem(icon: Icons.computer, label: 'Computer Skills', value: beneficiary.computerSkills ?? 'N/A'),
        DetailItem(icon: Icons.category, label: 'Sector Preferences', value: beneficiary.sectorPreferences ?? 'N/A'),
        DetailItem(icon: Icons.work, label: 'Employment', value: beneficiary.employment ?? 'N/A'),
        DetailItem(icon: Icons.support, label: 'Support Required Training & Learning', value: beneficiary.supportRequiredTrainingLearning ?? 'N/A'),
        DetailItem(icon: Icons.support, label: 'Support Required Entrepreneurship', value: beneficiary.supportRequiredEntrepreneurship ?? 'N/A'),
        DetailItem(icon: Icons.psychology, label: 'Career Guidance & Counselling', value: beneficiary.careerGuidanceCounselling ?? 'N/A'),
        DetailItem(icon: Icons.notes, label: 'General Notes', value: beneficiary.generalNotes ?? 'N/A'),
      ],
    );
  }
}
