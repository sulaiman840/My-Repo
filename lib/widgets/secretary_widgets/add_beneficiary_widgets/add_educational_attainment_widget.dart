import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';

class EducationalAttainmentManagerUpdateWidget extends StatefulWidget {
  final ValueNotifier<List<EducationalAttainment>> educationalAttainmentsNotifier;

  EducationalAttainmentManagerUpdateWidget({
    required List<EducationalAttainment> educationalAttainments,
  }) : educationalAttainmentsNotifier = ValueNotifier(educationalAttainments);

  @override
  _EducationalAttainmentManagerUpdateWidgetState createState() =>
      _EducationalAttainmentManagerUpdateWidgetState();
}

class _EducationalAttainmentManagerUpdateWidgetState extends State<EducationalAttainmentManagerUpdateWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<EducationalAttainment>>(
      valueListenable: widget.educationalAttainmentsNotifier,
      builder: (context, educationalAttainments, child) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context).translate('educational_attainments'),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: educationalAttainments.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        _buildTextFormField(
                          context,
                          label: AppLocalizations.of(context).translate('level'),
                          initialValue: educationalAttainments[index].educationalAttainmentLevel ?? '',
                          onChanged: (value) {
                            educationalAttainments[index].educationalAttainmentLevel = value;
                          },
                        ),
                        _buildTextFormField(
                          context,
                          label: AppLocalizations.of(context).translate('specialization'),
                          initialValue: educationalAttainments[index].specialization ?? '',
                          onChanged: (value) {
                            educationalAttainments[index].specialization = value;
                          },
                        ),
                        _buildTextFormField(
                          context,
                          label: AppLocalizations.of(context).translate('certificate'),
                          initialValue: educationalAttainments[index].certificate ?? '',
                          onChanged: (value) {
                            educationalAttainments[index].certificate = value;
                          },
                        ),
                        _buildTextFormField(
                          context,
                          label: AppLocalizations.of(context).translate('graduation_rate'),
                          initialValue: educationalAttainments[index].graduationRate ?? '',
                          onChanged: (value) {
                            educationalAttainments[index].graduationRate = value;
                          },
                        ),
                        _buildTextFormField(
                          context,
                          label: AppLocalizations.of(context).translate('academic_year'),
                          initialValue: educationalAttainments[index].academicYear ?? '',
                          onChanged: (value) {
                            educationalAttainments[index].academicYear = value;
                          },
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  },
                ),
                TextButton(
                  onPressed: () {
                    final newAttainment = EducationalAttainment();
                    widget.educationalAttainmentsNotifier.value = [
                      ...educationalAttainments,
                      newAttainment,
                    ];
                  },
                  child: Text(AppLocalizations.of(context).translate('add_educational_attainment')),
                ),
                if (educationalAttainments.isEmpty)
                  Text(
                    AppLocalizations.of(context).translate('no_educational_attainments_added'),
                    style: TextStyle(fontSize: 16),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextFormField(BuildContext context,
      {required String label,
        required String initialValue,
        required ValueChanged<String> onChanged}) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
    );
  }
}
