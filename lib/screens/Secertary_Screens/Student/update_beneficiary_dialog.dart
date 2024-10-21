import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../Bloc/secertary/student/beneficiary_cubit.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/color_manager.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';
import '../../../widgets/general_widgets/common_scaffold.dart';
import '../../../widgets/secretary_widgets/update_beneficiary_widgets/disability_widget.dart';
import '../../../widgets/secretary_widgets/update_beneficiary_widgets/educational_attainment_widget.dart';
import '../../../widgets/secretary_widgets/update_beneficiary_widgets/foreign_language_widget .dart';
import '../../../widgets/secretary_widgets/update_beneficiary_widgets/previous_training_course_widget.dart';
import '../../../widgets/secretary_widgets/update_beneficiary_widgets/professional_skill_widget.dart';

class BeneficiaryUpdateScreen extends StatelessWidget {
  final DataBeneficiary beneficiary;
  final VoidCallback onPop;

  BeneficiaryUpdateScreen({required this.beneficiary, required this.onPop});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    late int _serialNumber = beneficiary.serialNumber ?? 0;
    late String _date = beneficiary.date ?? '';
    late String _province = beneficiary.province ?? '';
    late String _name = beneficiary.name ?? '';
    late String _fatherName = beneficiary.fatherName ?? '';
    late String _motherName = beneficiary.motherName ?? '';
    late String _gender = beneficiary.gender ?? '';
    late String _dateOfBirth = beneficiary.dateOfBirth ?? '';
    late String _nots = beneficiary.nots ?? '';
    late String _maritalStatus = beneficiary.maritalStatus ?? '';
    late String _needAttendant = beneficiary.needAttendant ?? '';
    late int _numberFamilyMember = beneficiary.numberFamilyMember ?? 0;
    late String _losingBreadwinner = beneficiary.losingBreadwinner ?? '';
    late String _governorate = beneficiary.governorate ?? '';
    late String _address = beneficiary.address ?? '';
    late String _email = beneficiary.email ?? '';
    late String _numberLine = beneficiary.numberLine ?? '';
    late String _numberPhone = beneficiary.numberPhone ?? '';
    late String _numberId = beneficiary.numberId ?? '';
    late String _computerDriving = beneficiary.computerDriving ?? '';
    late String _computerSkills = beneficiary.computerSkills ?? '';
    late String _sectorPreferences = beneficiary.sectorPreferences ?? '';
    late String _employment = beneficiary.employment ?? '';
    late String _supportRequiredTrainingLearning = beneficiary.supportRequiredTrainingLearning ?? '';
    late String _supportRequiredEntrepreneurship = beneficiary.supportRequiredEntrepreneurship ?? '';
    late String _careerGuidanceCounselling = beneficiary.careerGuidanceCounselling ?? '';
    late String _generalNotes = beneficiary.generalNotes ?? '';
    late String _updatedAt = beneficiary.updatedAt ?? '';
    late String _createdAt = beneficiary.createdAt ?? '';

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
                    _buildEmailTextFormField(AppLocalizations.of(context).translate('email'), _email, (value) => _email = value!)
                  ]),
                  _buildRow([
                    _buildLineTextFormField(AppLocalizations.of(context).translate('number_line'), _numberLine, (value) => _numberLine = value!),
                    _buildPhoneTextFormField(AppLocalizations.of(context).translate('phone_number'), _numberPhone, (value) => _numberPhone = value!)
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
                  DisabilityWidget(
                    title: AppLocalizations.of(context).translate('personal_disabilities'),
                    disabilities: beneficiary.thereIsDisbility ?? [],
                  ),
                  DisabilityWidget(
                    title: AppLocalizations.of(context).translate('family_member_disabilities'),
                    disabilities: beneficiary.thereIsDisbilityFamilyMember ?? [],
                  ),
                  EducationalAttainmentWidget(
                    educationalAttainments: beneficiary.educationalAttainments ?? [],
                  ),
                  PreviousTrainingCourseWidget(
                    previousTrainingCourses: beneficiary.previousTrainingCourses ?? [],
                  ),
                  ForeignLanguageWidget(
                    foreignLanguages: beneficiary.foreignLanguages ?? [],
                  ),
                  ProfessionalSkillWidget(
                    professionalSkills: beneficiary.professionalSkills ?? [],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text(AppLocalizations.of(context).translate('update')),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final updatedBeneficiary = DataBeneficiary(
                          id: beneficiary.id,
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
                          numberLine: _numberLine,
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
                          thereIsDisbility: beneficiary.thereIsDisbility,
                          thereIsDisbilityFamilyMember: beneficiary.thereIsDisbilityFamilyMember,
                          educationalAttainments: beneficiary.educationalAttainments,
                          previousTrainingCourses: beneficiary.previousTrainingCourses,
                          foreignLanguages: beneficiary.foreignLanguages,
                          professionalSkills: beneficiary.professionalSkills,
                          createdAt: beneficiary.createdAt,
                          updatedAt: beneficiary.updatedAt,
                          educationalAttainment: beneficiary.educationalAttainment,
                        );
                        context.read<BeneficiaryCubit>().updateBeneficiary(updatedBeneficiary);
                        onPop();
                        context.go('/secretary_home?tab=1');
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
  Widget _buildEmailTextFormField(String label, String initialValue, FormFieldSetter<String> onSaved) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $label';
        }
        else if (!value.contains('@') || !value.endsWith('.com')) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      onSaved: onSaved,
    );
  }
  Widget _buildPhoneTextFormField(String label, String initialValue, FormFieldSetter<String> onSaved) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $label';
        }
        else if (value.length != 10) {
          return 'Phone number must be exactly 10 digits';
        }
        return null;
      },
      onSaved: onSaved,
    );
  }
  Widget _buildLineTextFormField(String label, String initialValue, FormFieldSetter<String> onSaved) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $label';
        }
        else if (value.length <= 7) {
          return 'Phone number must be at least 8 digits';
        }
        return null;
      },
      onSaved: onSaved,
    );
  }

}
