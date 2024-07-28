import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc/secertary/student/beneficiary_cubit.dart';
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

  BeneficiaryUpdateScreen({required this.beneficiary});

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

    return CommonScaffold(
      title: 'Update Beneficiary',
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
                    _buildTextFormField('Serial Number', _serialNumber.toString(), (value) => _serialNumber = int.parse(value!)),
                    _buildTextFormField('Date', _date, (value) => _date = value!)
                  ]),
                  _buildRow([
                    _buildTextFormField('Province', _province, (value) => _province = value!),
                    _buildTextFormField('Name', _name, (value) => _name = value!)
                  ]),
                  _buildRow([
                    _buildTextFormField('Father Name', _fatherName, (value) => _fatherName = value!),
                    _buildTextFormField('Mother Name', _motherName, (value) => _motherName = value!)
                  ]),
                  _buildRow([
                    _buildTextFormField('Gender', _gender, (value) => _gender = value!),
                    _buildTextFormField('Date of Birth', _dateOfBirth, (value) => _dateOfBirth = value!)
                  ]),
                  _buildRow([
                    _buildTextFormField('Notes', _nots, (value) => _nots = value!),
                    _buildTextFormField('Marital Status', _maritalStatus, (value) => _maritalStatus = value!)
                  ]),
                  _buildRow([
                    _buildTextFormField('Need Attendant', _needAttendant, (value) => _needAttendant = value!),
                    _buildTextFormField('Number of Family Members', _numberFamilyMember.toString(), (value) => _numberFamilyMember = int.parse(value!))
                  ]),
                  _buildRow([
                    _buildTextFormField('Losing Breadwinner', _losingBreadwinner, (value) => _losingBreadwinner = value!),
                    _buildTextFormField('Governorate', _governorate, (value) => _governorate = value!)
                  ]),
                  _buildRow([
                    _buildTextFormField('Address', _address, (value) => _address = value!),
                    _buildTextFormField('Email', _email, (value) => _email = value!)
                  ]),
                  _buildRow([
                    _buildTextFormField('Number Line', _numberLine, (value) => _numberLine = value!),
                    _buildTextFormField('Number Phone', _numberPhone, (value) => _numberPhone = value!)
                  ]),
                  _buildRow([
                    _buildTextFormField('Number ID', _numberId, (value) => _numberId = value!),
                    _buildTextFormField('Computer Driving', _computerDriving, (value) => _computerDriving = value!)
                  ]),
                  _buildRow([
                    _buildTextFormField('Computer Skills', _computerSkills, (value) => _computerSkills = value!),
                    _buildTextFormField('Sector Preferences', _sectorPreferences, (value) => _sectorPreferences = value!)
                  ]),
                  _buildRow([
                    _buildTextFormField('Employment', _employment, (value) => _employment = value!),
                    _buildTextFormField('Support Required for Training & Learning', _supportRequiredTrainingLearning, (value) => _supportRequiredTrainingLearning = value!)
                  ]),
                  _buildRow([
                    _buildTextFormField('Support Required for Entrepreneurship', _supportRequiredEntrepreneurship, (value) => _supportRequiredEntrepreneurship = value!),
                    _buildTextFormField('Career Guidance & Counselling', _careerGuidanceCounselling, (value) => _careerGuidanceCounselling = value!)
                  ]),
                  _buildTextFormField('General Notes', _generalNotes, (value) => _generalNotes = value!),
                  SizedBox(height: 20),
                  DisabilityWidget(
                    title: 'Personal Disabilities',
                    disabilities: beneficiary.thereIsDisbility?? [],
                  ),
                  DisabilityWidget(
                    title: 'Family Member Disabilities',
                    disabilities: beneficiary.thereIsDisbilityFamilyMember?? [],
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
                    child: Text('Update'),
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
                        Navigator.of(context).pop();
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
