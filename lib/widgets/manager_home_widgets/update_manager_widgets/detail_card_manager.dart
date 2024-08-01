import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/Pending Model/pending_beneficiary_request_model.dart';
import '../details_manager_widgets/disability_manager_details_section.dart';
import '../details_manager_widgets/display_educational__mamanger_attainment_widget.dart';
import '../details_manager_widgets/display_foreign_mamanger_language_widget.dart';
import '../details_manager_widgets/display_previous_training_course_manager_widget.dart';
import '../details_manager_widgets/display_professional_skill_manager_widget.dart';
import '../details_manager_widgets/section_manager_widget.dart';
import 'detail_items_list_manager.dart';

class DetailCard extends StatelessWidget {
  final RequsetPending beneficiary;

  const DetailCard({Key? key, required this.beneficiary}) : super(key: key);

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
            DetailItemsList(beneficiary: beneficiary),
            DisabilityManagerDetailsSection(icon: Icons.accessible, title: 'Personal Disabilities', disabilities: beneficiary.thereIsDisbility),
            DisabilityManagerDetailsSection(icon: Icons.accessible, title: 'Family Member Disabilities', disabilities: beneficiary.thereIsDisbilityFamilyMember),
            SectionManager(icon: Icons.school, title: 'Educational Attainments', items: beneficiary.educationalAttainments, builder: (items) => DisplayEducationalManagerAttainmentWidget(educationalAttainments: items)),
            SectionManager(icon: Icons.book, title: 'Previous Training Courses', items: beneficiary.previousTrainingCourses, builder: (items) => DisplayPreviousTrainingCourseManagerWidget(previousTrainingCourses: items)),
            SectionManager(icon: Icons.language, title: 'Foreign Languages', items: beneficiary.foreignLanguages, builder: (items) => DisplayForeignLanguageManangerWidget(foreignLanguages: items)),
            SectionManager(icon: Icons.build, title: 'Professional Skills', items: beneficiary.professionalSkills, builder: (items) => DisplayProfessionalSkillManagerWidget(professionalSkills: items)),
          ],
        ),
      ),
    );
  }
}
