import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../Bloc/manager/pending_beneficiary_cubit.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/color_manager.dart';
import '../../../models/Pending Model/pending_beneficiary_request_model.dart';
import '../../../widgets/general_widgets/common_scaffold.dart';
import '../../../widgets/manager_home_widgets/update_manager_widgets/disability_manager_update_widget.dart';
import '../../../widgets/manager_home_widgets/update_manager_widgets/educational_attainment_manager_update_widget.dart';
import '../../../widgets/manager_home_widgets/update_manager_widgets/foreign_language_manager_manager_widget .dart';
import '../../../widgets/manager_home_widgets/update_manager_widgets/previous_training_course_manager_update_widget.dart';
import '../../../widgets/manager_home_widgets/update_manager_widgets/professional_skill__manager_update_widget.dart';

class BeneficiaryEditManagerScreen extends StatelessWidget {
  final DataRequest beneficiary;
  final VoidCallback onPop;

  BeneficiaryEditManagerScreen({
    required this.beneficiary,
    required this.onPop,
  });

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    // Accessing fields within RequsetPending
    late RequsetPending reqPending = beneficiary.requsetPending!;
    late int _serialNumber = reqPending.serialNumber ?? 0;
    late String _date = reqPending.date ?? '';
    late String _province = reqPending.province ?? '';
    late String _name = reqPending.name ?? '';
    late String _fatherName = reqPending.fatherName ?? '';
    late String _motherName = reqPending.motherName ?? '';
    late String _gender = reqPending.gender ?? '';
    late String _dateOfBirth = reqPending.dateOfBirth ?? '';
    late String _nots = reqPending.nots ?? '';
    late String _maritalStatus = reqPending.maritalStatus ?? '';
    late String _needAttendant = reqPending.needAttendant ?? '';
    late int _numberFamilyMember = reqPending.numberFamilyMember ?? 0;
    late String _losingBreadwinner = reqPending.losingBreadwinner ?? '';
    late String _governorate = reqPending.governorate ?? '';
    late String _address = reqPending.address ?? '';
    late String _email = reqPending.email ?? '';
    late String _numberLine = reqPending.numberline ?? '';
    late String _numberPhone = reqPending.numberPhone ?? '';
    late String _numberId = reqPending.numberId ?? '';
    late String _computerDriving = reqPending.computerDriving ?? '';
    late String _computerSkills = reqPending.computerSkills ?? '';
    late String _sectorPreferences = reqPending.sectorPreferences ?? '';
    late String _employment = reqPending.employment ?? '';
    late String _supportRequiredTrainingLearning = reqPending.supportRequiredTrainingLearning ?? '';
    late String _supportRequiredEntrepreneurship = reqPending.supportRequiredEntrepreneurship ?? '';
    late String _careerGuidanceCounselling = reqPending.careerGuidanceCounselling ?? '';
    late String _generalNotes = reqPending.generalNotes ?? '';

    return CommonScaffold(
      title: AppLocalizations.of(context).translate('update_beneficiary'),
      scaffoldKey: GlobalKey<ScaffoldState>(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _buildRow([
                    _buildTextFormField(AppLocalizations.of(context).translate('serial_number'), _serialNumber.toString(), (value) => _serialNumber = int.parse(value!)),
                    _buildTextFormField(AppLocalizations.of(context).translate('date'), _date, (value) => _date = value!)
                  ]),
                  _buildRow([
                    _buildTextFormField(AppLocalizations.of(context).translate('province'), _province, (value) => _province = value!),
                    _buildTextFormField(AppLocalizations.of(context).translate('name'), _name, (value) => _name = value!)
                  ]),
                  _buildRow([
                    _buildTextFormField(AppLocalizations.of(context).translate('father_name'), _fatherName, (value) => _fatherName = value!),
                    _buildTextFormField(AppLocalizations.of(context).translate('mother_name'), _motherName, (value) => _motherName = value!)
                  ]),
                  _buildRow([
                    _buildTextFormField(AppLocalizations.of(context).translate('gender'), _gender, (value) => _gender = value!),
                    _buildTextFormField(AppLocalizations.of(context).translate('date_of_birth'), _dateOfBirth, (value) => _dateOfBirth = value!)
                  ]),
                  _buildRow([
                    _buildTextFormField(AppLocalizations.of(context).translate('notes'), _nots, (value) => _nots = value!),
                    _buildTextFormField(AppLocalizations.of(context).translate('marital_status'), _maritalStatus, (value) => _maritalStatus = value!)
                  ]),
                  _buildRow([
                    _buildTextFormField(AppLocalizations.of(context).translate('need_attendant'), _needAttendant, (value) => _needAttendant = value!),
                    _buildTextFormField(AppLocalizations.of(context).translate('number_family_members'), _numberFamilyMember.toString(), (value) => _numberFamilyMember = int.parse(value!))
                  ]),
                  _buildRow([
                    _buildTextFormField(AppLocalizations.of(context).translate('losing_breadwinner'), _losingBreadwinner, (value) => _losingBreadwinner = value!),
                    _buildTextFormField(AppLocalizations.of(context).translate('governorate'), _governorate, (value) => _governorate = value!)
                  ]),
                  _buildRow([
                    _buildTextFormField(AppLocalizations.of(context).translate('address'), _address, (value) => _address = value!),
                    _buildTextFormField(AppLocalizations.of(context).translate('email'), _email, (value) => _email = value!)
                  ]),
                  _buildRow([
                    _buildTextFormField(AppLocalizations.of(context).translate('number_line'), _numberLine, (value) => _numberLine = value!),
                    _buildTextFormField(AppLocalizations.of(context).translate('phone_number'), _numberPhone, (value) => _numberPhone = value!)
                  ]),
                  _buildRow([
                    _buildTextFormField(AppLocalizations.of(context).translate('number_ID'), _numberId, (value) => _numberId = value!),
                    _buildTextFormField(AppLocalizations.of(context).translate('computer_driving'), _computerDriving, (value) => _computerDriving = value!)
                  ]),
                  _buildRow([
                    _buildTextFormField(AppLocalizations.of(context).translate('computer_skills'), _computerSkills, (value) => _computerSkills = value!),
                    _buildTextFormField(AppLocalizations.of(context).translate('sector_preferences'), _sectorPreferences, (value) => _sectorPreferences = value!)
                  ]),
                  _buildRow([
                    _buildTextFormField(AppLocalizations.of(context).translate('employment'), _employment, (value) => _employment = value!),
                    _buildTextFormField(AppLocalizations.of(context).translate('support_required_for_training_learning'), _supportRequiredTrainingLearning, (value) => _supportRequiredTrainingLearning = value!)
                  ]),
                  _buildRow([
                    _buildTextFormField(AppLocalizations.of(context).translate('support_required_for_entrepreneurship'), _supportRequiredEntrepreneurship, (value) => _supportRequiredEntrepreneurship = value!),
                    _buildTextFormField(AppLocalizations.of(context).translate('career_guidance_counselling'), _careerGuidanceCounselling, (value) => _careerGuidanceCounselling = value!)
                  ]),
                  _buildTextFormField(AppLocalizations.of(context).translate('general_notes'), _generalNotes, (value) => _generalNotes = value!),
                  SizedBox(height: 20),
                  DisabilityManagerUpdateWidget(
                    title: AppLocalizations.of(context).translate('personal_disabilities'),
                    disabilities: reqPending.thereIsDisbility ?? [],
                  ),
                  DisabilityManagerUpdateWidget(
                    title: AppLocalizations.of(context).translate('family_member_disabilities'),
                    disabilities: reqPending.thereIsDisbilityFamilyMember ?? [],
                  ),
                  EducationalAttainmentManagerUpdateWidget(
                    educationalAttainments: reqPending.educationalAttainments ?? [],
                  ),
                  PreviousTrainingCourseManagerUpdateWidget(
                    previousTrainingCourses: reqPending.previousTrainingCourses ?? [],
                  ),
                  ForeignLanguageManagerUpdateWidget(
                    foreignLanguages: reqPending.foreignLanguages ?? [],
                  ),
                  ProfessionalSkillManagerUpdateWidget(
                    professionalSkills: reqPending.professionalSkills ?? [],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text(AppLocalizations.of(context).translate('update')),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        final updatedRequsetPending = RequsetPending(
                          serialNumber: _serialNumber,
                          date: _date,
                          province: _province,
                          name: _name,
                          fatherName: _fatherName,
                          motherName: _motherName,
                          gender: _gender,
                          dateOfBirth: _dateOfBirth,
                          nots: _nots,
                          maritalStatus: _maritalStatus,
                          needAttendant: _needAttendant,
                          numberFamilyMember: _numberFamilyMember,
                          losingBreadwinner: _losingBreadwinner,
                          governorate: _governorate,
                          address: _address,
                          email: _email,
                          numberline: _numberLine,
                          numberPhone: _numberPhone,
                          numberId: _numberId,
                          computerDriving: _computerDriving,
                          computerSkills: _computerSkills,
                          sectorPreferences: _sectorPreferences,
                          employment: _employment,
                          supportRequiredTrainingLearning: _supportRequiredTrainingLearning,
                          supportRequiredEntrepreneurship: _supportRequiredEntrepreneurship,
                          careerGuidanceCounselling: _careerGuidanceCounselling,
                          generalNotes: _generalNotes,
                          thereIsDisbility: reqPending.thereIsDisbility,
                          thereIsDisbilityFamilyMember: reqPending.thereIsDisbilityFamilyMember,
                          educationalAttainments: reqPending.educationalAttainments,
                          previousTrainingCourses: reqPending.previousTrainingCourses,
                          foreignLanguages: reqPending.foreignLanguages,
                          professionalSkills: reqPending.professionalSkills,
                        );

                        // Update the DataRequest object
                        final updatedDataRequest = beneficiary.copyWith(
                          requsetPending: updatedRequsetPending,
                        );

                        context.read<PendingBeneficiaryCubit>().updateBeneficiary(
                          updatedDataRequest.id!,  // Pass the ID
                          _serialNumber,
                          _date,
                          _province,
                          _name,
                          _fatherName,
                          _motherName,
                          _gender,
                          _dateOfBirth,
                          _nots,
                          _maritalStatus,
                          reqPending.thereIsDisbility ?? [],
                          _needAttendant,
                          _numberFamilyMember,
                          reqPending.thereIsDisbilityFamilyMember ?? [],
                          _losingBreadwinner,
                          _governorate,
                          _address,
                          _email,
                          _numberLine,
                          _numberPhone,
                          _numberId,
                          reqPending.educationalAttainments ?? [],
                          reqPending.previousTrainingCourses ?? [],
                          reqPending.foreignLanguages ?? [],
                          _computerDriving,
                          _computerSkills,
                          reqPending.professionalSkills ?? [],
                          _sectorPreferences,
                          _employment,
                          _supportRequiredTrainingLearning,
                          _supportRequiredEntrepreneurship,
                          _careerGuidanceCounselling,
                          _generalNotes,
                        );
                        onPop();
                        context.go('/manager_home?tab=3');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: children
            .map((child) => Expanded(child: Padding(padding: const EdgeInsets.all(8.0), child: child)))
            .toList(),
      ),
    );
  }

  Widget _buildTextFormField(String label, String initialValue, FormFieldSetter<String> onSaved) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
      onSaved: onSaved,
    );
  }
}
