import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/localization/app_localizations.dart';
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
        DetailItem(icon: Icons.confirmation_number, label: AppLocalizations.of(context).translate('serial_number'), value: beneficiary.serialNumber.toString() ?? 'N/A'),
        DetailItem(icon: Icons.date_range, label: AppLocalizations.of(context).translate('date'), value: beneficiary.date ?? 'N/A'),
        DetailItem(icon: Icons.location_city, label: AppLocalizations.of(context).translate('province'), value: beneficiary.province ?? 'N/A'),
        DetailItem(icon: Icons.person, label: AppLocalizations.of(context).translate('name'), value: beneficiary.name ?? 'N/A'),
        DetailItem(icon: Icons.person_outline, label: AppLocalizations.of(context).translate('father_name'), value: beneficiary.fatherName ?? 'N/A'),
        DetailItem(icon: Icons.person_outline, label: AppLocalizations.of(context).translate('mother_name'), value: beneficiary.motherName ?? 'N/A'),
        DetailItem(icon: Icons.wc, label: AppLocalizations.of(context).translate('gender'), value: beneficiary.gender ?? 'N/A'),
        DetailItem(icon: Icons.cake, label: AppLocalizations.of(context).translate('date_of_birth'), value: beneficiary.dateOfBirth ?? 'N/A'),
        DetailItem(icon: Icons.notes, label: AppLocalizations.of(context).translate('notes'), value: beneficiary.nots ?? 'N/A'),
        DetailItem(icon: Icons.family_restroom, label: AppLocalizations.of(context).translate('marital_status'), value: beneficiary.maritalStatus ?? 'N/A'),
        DetailItem(icon: Icons.accessibility, label: AppLocalizations.of(context).translate('need_attendant'), value: beneficiary.needAttendant ?? 'N/A'),
        DetailItem(icon: Icons.group, label: AppLocalizations.of(context).translate('number_family_members'), value: beneficiary.numberFamilyMember.toString() ?? 'N/A'),
        DetailItem(icon: Icons.group_off, label: AppLocalizations.of(context).translate('losing_breadwinner'), value: beneficiary.losingBreadwinner ?? 'N/A'),
        DetailItem(icon: Icons.map, label: AppLocalizations.of(context).translate('governorate'), value: beneficiary.governorate ?? 'N/A'),
        DetailItem(icon: Icons.home, label: AppLocalizations.of(context).translate('address'), value: beneficiary.address ?? 'N/A'),
        DetailItem(icon: Icons.email, label: AppLocalizations.of(context).translate('email'), value: beneficiary.email ?? 'N/A'),
        DetailItem(icon: Icons.phone, label: AppLocalizations.of(context).translate('number_line'), value: beneficiary.numberline ?? 'N/A'),
        //      DetailItem(icon: Icons.phone_android, label: 'Number Phone', value: beneficiary.numberPhone.toString() ?? 'N/A'),
        DetailItem(icon: Icons.perm_identity, label: AppLocalizations.of(context).translate('number_ID'), value: beneficiary.numberId ?? 'N/A'),
        DetailItem(icon: Icons.computer, label: AppLocalizations.of(context).translate('computer_driving'), value: beneficiary.computerDriving ?? 'N/A'),
        DetailItem(icon: Icons.computer, label: AppLocalizations.of(context).translate('computer_skills'), value: beneficiary.computerSkills ?? 'N/A'),
        DetailItem(icon: Icons.category, label: AppLocalizations.of(context).translate('sector_preferences'), value: beneficiary.sectorPreferences ?? 'N/A'),
        DetailItem(icon: Icons.work, label: AppLocalizations.of(context).translate('employment'), value: beneficiary.employment ?? 'N/A'),
        DetailItem(icon: Icons.support, label: AppLocalizations.of(context).translate('support_required_for_training_learning'), value: beneficiary.supportRequiredTrainingLearning ?? 'N/A'),
        DetailItem(icon: Icons.support, label: AppLocalizations.of(context).translate('support_required_entrepreneurship'), value: beneficiary.supportRequiredEntrepreneurship ?? 'N/A'),
        DetailItem(icon: Icons.psychology, label: AppLocalizations.of(context).translate('career_guidance_counselling'), value: beneficiary.careerGuidanceCounselling ?? 'N/A'),
        DetailItem(icon: Icons.notes, label: AppLocalizations.of(context).translate('general_notes'), value: beneficiary.generalNotes ?? 'N/A'),
      ],
    );
  }
}
