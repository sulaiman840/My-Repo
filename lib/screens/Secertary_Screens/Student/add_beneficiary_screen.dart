import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc/secertary/student/beneficiary_cubit.dart';
import '../../../core/utils/color_manager.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';
import '../../../widgets/general_widgets/common_scaffold.dart';
import '../../../widgets/secretary_widgets/add_beneficiary_widgets/add_disability_widget.dart';
import '../../../widgets/secretary_widgets/add_beneficiary_widgets/add_educational_attainment_widget.dart';
import '../../../widgets/secretary_widgets/add_beneficiary_widgets/add_foreign_language_widget.dart';
import '../../../widgets/secretary_widgets/add_beneficiary_widgets/add_previous_training_course_widget.dart';
import '../../../widgets/secretary_widgets/add_beneficiary_widgets/add_professional_skill_widget.dart';

class BeneficiaryCreateScreen extends StatefulWidget {
  final VoidCallback onBeneficiaryAdded;

  BeneficiaryCreateScreen({required this.onBeneficiaryAdded});

  @override
  _BeneficiaryCreateScreenState createState() => _BeneficiaryCreateScreenState();
}

class _BeneficiaryCreateScreenState extends State<BeneficiaryCreateScreen> {
  final _formKey = GlobalKey<FormState>();


  int _serialNumber = 662;
  String _date = '2024-06-22';
  String _province = 'Example Province';
  String _name = 'John Doe';
  String _fatherName = 'Father Doe';
  String _motherName = 'Mother Doe';
  String _gender = 'Male';
  String _dateOfBirth = '1990-01-01';
  String _nots = 'Some notes here';
  String _maritalStatus = 'Married';
  String _needAttendant = 'Yes';
  int _numberFamilyMember = 4;
  String _losingBreadwinner = 'No';
  String _governorate = 'Example Governorate';
  String _address = 'Example Address';
  String _email = 'john.doe@example.com';
  String _numberLine = '12345';
  String _numberPhone = '1234567890';
  String _numberId = 'ID123';
  String _computerDriving = 'Yes';
  String _computerSkills = 'Programming, Web Development';
  String _sectorPreferences = 'IT';
  String _employment = 'Employed';
  String _supportRequiredTrainingLearning = 'Yes';
  String _supportRequiredEntrepreneurship = 'No';
  String _careerGuidanceCounselling = 'Yes';
  String _generalNotes = 'General notes here';

  List<Disability> _personalDisabilities = [
    Disability(nameDisability: 'Disability 1', rateDisability: 'Rate 1'),
    Disability(nameDisability: 'Disability 2', rateDisability: 'Rate 2')
  ];
  List<Disability> _familyDisabilities = [
    Disability(nameDisability: 'Disability 3')
  ];
  List<EducationalAttainment> _educationalAttainments = [
    EducationalAttainment(
        educationalAttainmentLevel: 'University',
        specialization: 'Specialization 1',
        certificate: 'Certificate 1',
        graduationRate: 'Graduation Rate 1',
        academicYear: 'Academic Year 1'
    )
  ];
  List<PreviousTrainingCourse> _previousTrainingCourses = [
    PreviousTrainingCourse(
        certificateAndType: 'Certificate Type 1',
        executingAgency: 'Agency 1',
        dateExecute: '2022-05-01'
    ),
    PreviousTrainingCourse(
        certificateAndType: 'Certificate Type 2',
        executingAgency: 'Agency 2',
        dateExecute: '2023-07-15'
    )
  ];
  List<ForeignLanguage> _foreignLanguages = [
    ForeignLanguage(nameLanguage: 'Language 1', level: 'Level 1'),
    ForeignLanguage(nameLanguage: 'Language 2', level: 'Level 2')
  ];
  List<ProfessionalSkill> _professionalSkills = [
    ProfessionalSkill(
        jobTitle: 'Job Title 1',
        start: '2020-01-01',
        end: '2021-01-01',
        jobTasks: 'Task 1, Task 2'
    ),
    ProfessionalSkill(
        jobTitle: 'Job Title 2',
        start: '2021-02-01',
        end: '2022-02-01',
        jobTasks: 'Task 3, Task 4'
    )
  ];

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: 'Add Beneficiary',
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
                    _buildTextFormField('Serial Number', (value) => _serialNumber = int.parse(value!), initialValue: _serialNumber.toString()),
                    _buildTextFormField('Date', (value) => _date = value!, initialValue: _date)
                  ]),
                  _buildRow([
                    _buildTextFormField('Province', (value) => _province = value!, initialValue: _province),
                    _buildTextFormField('Name', (value) => _name = value!, initialValue: _name)
                  ]),
                  _buildRow([
                    _buildTextFormField('Father Name', (value) => _fatherName = value!, initialValue: _fatherName),
                    _buildTextFormField('Mother Name', (value) => _motherName = value!, initialValue: _motherName)
                  ]),
                  _buildRow([
                    _buildTextFormField('Gender', (value) => _gender = value!, initialValue: _gender),
                    _buildTextFormField('Date of Birth', (value) => _dateOfBirth = value!, initialValue: _dateOfBirth)
                  ]),
                  _buildRow([
                    _buildTextFormField('Notes', (value) => _nots = value!, initialValue: _nots),
                    _buildTextFormField('Marital Status', (value) => _maritalStatus = value!, initialValue: _maritalStatus)
                  ]),
                  _buildRow([
                    _buildTextFormField('Need Attendant', (value) => _needAttendant = value!, initialValue: _needAttendant),
                    _buildTextFormField('Number of Family Members', (value) => _numberFamilyMember = int.parse(value!), initialValue: _numberFamilyMember.toString())
                  ]),
                  _buildRow([
                    _buildTextFormField('Losing Breadwinner', (value) => _losingBreadwinner = value!, initialValue: _losingBreadwinner),
                    _buildTextFormField('Governorate', (value) => _governorate = value!, initialValue: _governorate)
                  ]),
                  _buildRow([
                    _buildTextFormField('Address', (value) => _address = value!, initialValue: _address),
                    _buildTextFormField('Email', (value) => _email = value!, initialValue: _email)
                  ]),
                  _buildRow([
                    _buildTextFormField('Number Line', (value) => _numberLine = value!, initialValue: _numberLine),
                    _buildTextFormField('Number Phone', (value) => _numberPhone = value!, initialValue: _numberPhone)
                  ]),
                  _buildRow([
                    _buildTextFormField('Number ID', (value) => _numberId = value!, initialValue: _numberId),
                    _buildTextFormField('Computer Driving', (value) => _computerDriving = value!, initialValue: _computerDriving)
                  ]),
                  _buildRow([
                    _buildTextFormField('Computer Skills', (value) => _computerSkills = value!, initialValue: _computerSkills),
                    _buildTextFormField('Sector Preferences', (value) => _sectorPreferences = value!, initialValue: _sectorPreferences)
                  ]),
                  _buildRow([
                    _buildTextFormField('Employment', (value) => _employment = value!, initialValue: _employment),
                    _buildTextFormField('Support Required for Training & Learning', (value) => _supportRequiredTrainingLearning = value!, initialValue: _supportRequiredTrainingLearning)
                  ]),
                  _buildRow([
                    _buildTextFormField('Support Required for Entrepreneurship', (value) => _supportRequiredEntrepreneurship = value!, initialValue: _supportRequiredEntrepreneurship),
                    _buildTextFormField('Career Guidance & Counselling', (value) => _careerGuidanceCounselling = value!, initialValue: _careerGuidanceCounselling)
                  ]),
                  _buildTextFormField('General Notes', (value) => _generalNotes = value!, initialValue: _generalNotes),
                  SizedBox(height: 20),
                  AddDisabilityWidget(
                    title: 'Personal Disabilities',
                    disabilities: _personalDisabilities,
                    onChanged: (List<Disability> value) => setState(() => _personalDisabilities = value),
                  ),
                  AddDisabilityWidget(
                    title: 'Family Member Disabilities',
                    disabilities: _familyDisabilities,
                    onChanged: (List<Disability> value) => setState(() => _familyDisabilities = value),
                  ),
                  AddEducationalAttainmentWidget(
                    educationalAttainments: _educationalAttainments,
                    onChanged: (List<EducationalAttainment> value) => setState(() => _educationalAttainments = value),
                  ),
                  AddPreviousTrainingCourseWidget(
                    previousTrainingCourses: _previousTrainingCourses,
                    onChanged: (List<PreviousTrainingCourse> value) => setState(() => _previousTrainingCourses = value),
                  ),
                  AddForeignLanguageWidget(
                    foreignLanguages: _foreignLanguages,
                    onChanged: (List<ForeignLanguage> value) => setState(() => _foreignLanguages = value),
                  ),
                  AddProfessionalSkillWidget(
                    professionalSkills: _professionalSkills,
                    onChanged: (List<ProfessionalSkill> value) => setState(() => _professionalSkills = value),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('Add'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final newBeneficiary = DataBeneficiary(
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
                          thereIsDisbility: _personalDisabilities,
                          thereIsDisbilityFamilyMember: _familyDisabilities,
                          educationalAttainments: _educationalAttainments,
                          previousTrainingCourses: _previousTrainingCourses,
                          foreignLanguages: _foreignLanguages,
                          professionalSkills: _professionalSkills,
                        );
                        context.read<BeneficiaryCubit>().addBeneficiary(newBeneficiary);
                        widget.onBeneficiaryAdded();
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

  Widget _buildTextFormField(String label, FormFieldSetter<String> onSaved, {required String initialValue}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      initialValue: initialValue,
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
