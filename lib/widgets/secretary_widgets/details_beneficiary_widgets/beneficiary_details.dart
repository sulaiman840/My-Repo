import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project2/widgets/secretary_widgets/details_beneficiary_widgets/section_widget.dart';

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
                DetailItem(icon: Icons.confirmation_number, label: 'Serial Number', value: beneficiary.serialNumber.toString()),
                DetailItem(icon: Icons.date_range, label: 'Date', value: beneficiary.date ?? ''),
                DetailItem(icon: Icons.location_city, label: 'Province', value: beneficiary.province ?? ''),
                DetailItem(icon: Icons.person, label: 'Name', value: beneficiary.name ?? ''),
                DetailItem(icon: Icons.person_outline, label: 'Father Name', value: beneficiary.fatherName ?? ''),
                DetailItem(icon: Icons.person_outline, label: 'Mother Name', value: beneficiary.motherName ?? ''),
                DetailItem(icon: Icons.wc, label: 'Gender', value: beneficiary.gender ?? ''),
                DetailItem(icon: Icons.cake, label: 'Date of Birth', value: beneficiary.dateOfBirth ?? ''),
                DetailItem(icon: Icons.notes, label: 'Notes', value: beneficiary.nots ?? ''),
                DetailItem(icon: Icons.family_restroom, label: 'Marital Status', value: beneficiary.maritalStatus ?? ''),
                DetailItem(icon: Icons.accessibility, label: 'Need Attendant', value: beneficiary.needAttendant ?? ''),
                DetailItem(icon: Icons.group, label: 'Number of Family Members', value: beneficiary.numberFamilyMember.toString()),
                DetailItem(icon: Icons.group_off, label: 'Losing Breadwinner', value: beneficiary.losingBreadwinner ?? ''),
                DetailItem(icon: Icons.map, label: 'Governorate', value: beneficiary.governorate ?? ''),
                DetailItem(icon: Icons.home, label: 'Address', value: beneficiary.address ?? ''),
                DetailItem(icon: Icons.email, label: 'Email', value: beneficiary.email ?? ''),
                DetailItem(icon: Icons.phone, label: 'Number Line', value: beneficiary.numberLine ?? ''),
              DetailItem(icon: Icons.phone_android, label: 'Number Phone', value: beneficiary.numberPhone  ?? ''),

                DetailItem(icon: Icons.perm_identity, label: 'Number ID', value: beneficiary.numberId ?? ''),
                DetailItem(icon: Icons.school, label: 'Educational Attainment', value: beneficiary.educationalAttainment ?? ''),
                DetailItem(icon: Icons.computer, label: 'Computer Driving', value: beneficiary.computerDriving ?? ''),
                DetailItem(icon: Icons.computer, label: 'Computer Skills', value: beneficiary.computerSkills ?? ''),
                DetailItem(icon: Icons.category, label: 'Sector Preferences', value: beneficiary.sectorPreferences ?? ''),
                DetailItem(icon: Icons.work, label: 'Employment', value: beneficiary.employment ?? ''),
                DetailItem(icon: Icons.support, label: 'Support Required Training & Learning', value: beneficiary.supportRequiredTrainingLearning ?? ''),
                DetailItem(icon: Icons.support, label: 'Support Required Entrepreneurship', value: beneficiary.supportRequiredEntrepreneurship ?? ''),
                DetailItem(icon: Icons.psychology, label: 'Career Guidance & Counselling', value: beneficiary.careerGuidanceCounselling ?? ''),
                DetailItem(icon: Icons.notes, label: 'General Notes', value: beneficiary.generalNotes ?? ''),
              ],
            ),
            DisabilitySection(icon: Icons.accessible, title: 'Personal Disabilities', disabilities: beneficiary.thereIsDisbility),
            DisabilitySection(icon: Icons.accessible, title: 'Family Member Disabilities', disabilities: beneficiary.thereIsDisbilityFamilyMember),
            Section(icon: Icons.school, title: 'Educational Attainments', items: beneficiary.educationalAttainments, builder: (items) => DisplayEducationalAttainmentWidget(educationalAttainments: items)),
            Section(icon: Icons.book, title: 'Previous Training Courses', items: beneficiary.previousTrainingCourses, builder: (items) => DisplayPreviousTrainingCourseWidget(previousTrainingCourses: items)),
            Section(icon: Icons.language, title: 'Foreign Languages', items: beneficiary.foreignLanguages, builder: (items) => DisplayForeignLanguageWidget(foreignLanguages: items)),
            Section(icon: Icons.build, title: 'Professional Skills', items: beneficiary.professionalSkills, builder: (items) => DisplayProfessionalSkillWidget(professionalSkills: items)),
          ],
        ),
      ),
    );
  }
}
