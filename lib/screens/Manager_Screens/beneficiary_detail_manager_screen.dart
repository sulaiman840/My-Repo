import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/pending_beneficiary_request_model.dart';
import '../../core/utils/color_manager.dart';
import 'package:project2/widgets/secretary_widgets/details_beneficiary_widgets/section_widget.dart';
import 'package:project2/widgets/secretary_widgets/details_beneficiary_widgets/detail_item_widget.dart';
import 'package:project2/widgets/secretary_widgets/details_beneficiary_widgets/disability_section.dart';
import 'package:project2/widgets/secretary_widgets/details_beneficiary_widgets/display_educational_attainment_widget.dart';
import 'package:project2/widgets/secretary_widgets/details_beneficiary_widgets/display_foreign_language_widget.dart';
import 'package:project2/widgets/secretary_widgets/details_beneficiary_widgets/display_previous_training_course_widget.dart';
import 'package:project2/widgets/secretary_widgets/details_beneficiary_widgets/display_professional_skill_widget.dart';
import '../../widgets/general_widgets/common_scaffold.dart';
import '../../Bloc/secertary/student/pending_beneficiary_cubit.dart';

class BeneficiaryDetailManagerScreen extends StatelessWidget {
  final DataRequest pendingRequest;

  const BeneficiaryDetailManagerScreen({Key? key, required this.pendingRequest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final beneficiary = pendingRequest.requsetPending;

    return CommonScaffold(
      title: beneficiary?.name ?? 'Beneficiary Details',
      scaffoldKey: GlobalKey<ScaffoldState>(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () => _approveRequest(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,

                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('Approve', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
                SizedBox(width: 20,),
                ElevatedButton(
                  onPressed: () => _rejectRequest(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('Reject', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 16),
            Card(
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
                        DetailItem(icon: Icons.confirmation_number, label: 'Serial Number', value: beneficiary?.serialNumber.toString() ?? 'N/A'),
                        DetailItem(icon: Icons.date_range, label: 'Date', value: beneficiary?.date ?? 'N/A'),
                        DetailItem(icon: Icons.location_city, label: 'Province', value: beneficiary?.province ?? 'N/A'),
                        DetailItem(icon: Icons.person, label: 'Name', value: beneficiary?.name ?? 'N/A'),
                        DetailItem(icon: Icons.person_outline, label: 'Father Name', value: beneficiary?.fatherName ?? 'N/A'),
                        DetailItem(icon: Icons.person_outline, label: 'Mother Name', value: beneficiary?.motherName ?? 'N/A'),
                        DetailItem(icon: Icons.wc, label: 'Gender', value: beneficiary?.gender ?? 'N/A'),
                        DetailItem(icon: Icons.cake, label: 'Date of Birth', value: beneficiary?.dateOfBirth ?? 'N/A'),
                        DetailItem(icon: Icons.notes, label: 'Notes', value: beneficiary?.nots ?? 'N/A'),
                        DetailItem(icon: Icons.family_restroom, label: 'Marital Status', value: beneficiary?.maritalStatus ?? 'N/A'),
                        DetailItem(icon: Icons.accessibility, label: 'Need Attendant', value: beneficiary?.needAttendant ?? 'N/A'),
                        DetailItem(icon: Icons.group, label: 'Number of Family Members', value: beneficiary?.numberFamilyMember.toString() ?? 'N/A'),
                        DetailItem(icon: Icons.group_off, label: 'Losing Breadwinner', value: beneficiary?.losingBreadwinner ?? 'N/A'),
                        DetailItem(icon: Icons.map, label: 'Governorate', value: beneficiary?.governorate ?? 'N/A'),
                        DetailItem(icon: Icons.home, label: 'Address', value: beneficiary?.address ?? 'N/A'),
                        DetailItem(icon: Icons.email, label: 'Email', value: beneficiary?.email ?? 'N/A'),
                        DetailItem(icon: Icons.phone, label: 'Number Line', value: beneficiary?.numberPhone ?? 'N/A'),
                        DetailItem(icon: Icons.phone_android, label: 'Number Phone', value: beneficiary?.numberPhone ?? 'N/A'),
                        DetailItem(icon: Icons.perm_identity, label: 'Number ID', value: beneficiary?.numberId ?? 'N/A'),
                        DetailItem(icon: Icons.computer, label: 'Computer Driving', value: beneficiary?.computerDriving ?? 'N/A'),
                        DetailItem(icon: Icons.computer, label: 'Computer Skills', value: beneficiary?.computerSkills ?? 'N/A'),
                        DetailItem(icon: Icons.category, label: 'Sector Preferences', value: beneficiary?.sectorPreferences ?? 'N/A'),
                        DetailItem(icon: Icons.work, label: 'Employment', value: beneficiary?.employment ?? 'N/A'),
                        DetailItem(icon: Icons.support, label: 'Support Required Training & Learning', value: beneficiary?.supportRequiredTrainingLearning ?? 'N/A'),
                        DetailItem(icon: Icons.support, label: 'Support Required Entrepreneurship', value: beneficiary?.supportRequiredEntrepreneurship ?? 'N/A'),
                        DetailItem(icon: Icons.psychology, label: 'Career Guidance & Counselling', value: beneficiary?.careerGuidanceCounselling ?? 'N/A'),
                        DetailItem(icon: Icons.notes, label: 'General Notes', value: beneficiary?.generalNotes ?? 'N/A'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _approveRequest(BuildContext context) {
    context.read<PendingBeneficiaryCubit>().approveRequest(pendingRequest.id!);
    Navigator.pop(context);
  }

  void _rejectRequest(BuildContext context) {
    context.read<PendingBeneficiaryCubit>().rejectRequest(pendingRequest.id!);
    Navigator.pop(context);
  }
}
