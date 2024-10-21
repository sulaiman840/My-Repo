import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project2/widgets/secretary_widgets/details_beneficiary_widgets/section_widget.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';
import 'detail_item_widget.dart';
import 'disability_section.dart';
import 'display_educational_attainment_widget.dart';
import 'display_foreign_language_widget.dart';
import 'display_previous_training_course_widget.dart';
import 'display_professional_skill_widget.dart';

class BeneficiaryDetails extends StatelessWidget {
  final DataBeneficiary beneficiary;

  BeneficiaryDetails({required this.beneficiary});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              children: [
                DetailItem(icon: Icons.confirmation_number, label: AppLocalizations.of(context).translate('serial_number'), value: beneficiary.serialNumber.toString()),
                DetailItem(icon: Icons.date_range, label: AppLocalizations.of(context).translate('date'), value: beneficiary.date ?? ''),
                DetailItem(icon: Icons.location_city, label: AppLocalizations.of(context).translate('province'), value: beneficiary.province ?? ''),
                DetailItem(icon: Icons.person, label: AppLocalizations.of(context).translate('name'), value: beneficiary.name ?? ''),
                DetailItem(icon: Icons.person_outline, label: AppLocalizations.of(context).translate('father_name'), value: beneficiary.fatherName ?? ''),
                DetailItem(icon: Icons.person_outline, label: AppLocalizations.of(context).translate('mother_name'), value: beneficiary.motherName ?? ''),
                DetailItem(icon: Icons.wc, label: AppLocalizations.of(context).translate('gender'), value: beneficiary.gender ?? ''),
                DetailItem(icon: Icons.cake, label: AppLocalizations.of(context).translate('date_of_birth'), value: beneficiary.dateOfBirth ?? ''),
                DetailItem(icon: Icons.notes, label: AppLocalizations.of(context).translate('notes'), value: beneficiary.nots ?? ''),
                DetailItem(icon: Icons.family_restroom, label: AppLocalizations.of(context).translate('marital_status'), value: beneficiary.maritalStatus ?? ''),
                DetailItem(icon: Icons.accessibility, label: AppLocalizations.of(context).translate('need_attendant'), value: beneficiary.needAttendant ?? ''),
                DetailItem(icon: Icons.group, label: AppLocalizations.of(context).translate('number_family_members'), value: beneficiary.numberFamilyMember.toString()),
                DetailItem(icon: Icons.group_off, label: AppLocalizations.of(context).translate('losing_breadwinner'), value: beneficiary.losingBreadwinner ?? ''),
                DetailItem(icon: Icons.map, label: AppLocalizations.of(context).translate('governorate'), value: beneficiary.governorate ?? ''),
                DetailItem(icon: Icons.home, label: AppLocalizations.of(context).translate('address'), value: beneficiary.address ?? ''),
                DetailItem(icon: Icons.email, label: AppLocalizations.of(context).translate('email'), value: beneficiary.email ?? ''),
                DetailItem(icon: Icons.phone, label: AppLocalizations.of(context).translate('number_line'), value: beneficiary.numberLine ?? ''),
              DetailItem(icon: Icons.phone_android, label: AppLocalizations.of(context).translate('number_phone'), value: beneficiary.numberPhone  ?? ''),

                DetailItem(icon: Icons.perm_identity, label: AppLocalizations.of(context).translate('number_ID'), value: beneficiary.numberId ?? ''),
                DetailItem(icon: Icons.school, label: AppLocalizations.of(context).translate('educational_attainments'), value: beneficiary.educationalAttainment ?? ''),
                DetailItem(icon: Icons.computer, label: AppLocalizations.of(context).translate('computer_driving'), value: beneficiary.computerDriving ?? ''),
                DetailItem(icon: Icons.computer, label: AppLocalizations.of(context).translate('computer_skills'), value: beneficiary.computerSkills ?? ''),
                DetailItem(icon: Icons.category, label: AppLocalizations.of(context).translate('sector_preferences'), value: beneficiary.sectorPreferences ?? ''),
                DetailItem(icon: Icons.work, label: AppLocalizations.of(context).translate('employment'), value: beneficiary.employment ?? ''),
                DetailItem(icon: Icons.support, label: AppLocalizations.of(context).translate('support_required_training_&_learning'), value: beneficiary.supportRequiredTrainingLearning ?? ''),
                DetailItem(icon: Icons.support, label: AppLocalizations.of(context).translate('support_required_entrepreneurship'), value: beneficiary.supportRequiredEntrepreneurship ?? ''),
                DetailItem(icon: Icons.psychology, label: AppLocalizations.of(context).translate('career_guidance_counselling'), value: beneficiary.careerGuidanceCounselling ?? ''),
                DetailItem(icon: Icons.notes, label: AppLocalizations.of(context).translate('general_notes'), value: beneficiary.generalNotes ?? ''),
              ],
            ),
            DisabilitySection(icon: Icons.accessible, title: AppLocalizations.of(context).translate('personal_disabilities'), disabilities: beneficiary.thereIsDisbility),
            DisabilitySection(icon: Icons.accessible, title: AppLocalizations.of(context).translate('family_member_disabilities'), disabilities: beneficiary.thereIsDisbilityFamilyMember),
            Section(icon: Icons.school, title: AppLocalizations.of(context).translate('educational_attainments'), items: beneficiary.educationalAttainments, builder: (items) => DisplayEducationalAttainmentWidget(educationalAttainments: items)),
            Section(icon: Icons.book, title: AppLocalizations.of(context).translate('previous_training_courses'), items: beneficiary.previousTrainingCourses, builder: (items) => DisplayPreviousTrainingCourseWidget(previousTrainingCourses: items)),
            Section(icon: Icons.language, title: AppLocalizations.of(context).translate('foreign_languages'), items: beneficiary.foreignLanguages, builder: (items) => DisplayForeignLanguageWidget(foreignLanguages: items)),
            Section(icon: Icons.build, title: AppLocalizations.of(context).translate('professional_skills'), items: beneficiary.professionalSkills, builder: (items) => DisplayProfessionalSkillWidget(professionalSkills: items)),
          ],
        ),
      ),
    );
  }
}
