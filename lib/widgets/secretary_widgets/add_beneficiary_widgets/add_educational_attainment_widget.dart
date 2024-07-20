import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/color_manager.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';

class AddEducationalAttainmentWidget extends StatelessWidget {
  final List<EducationalAttainment> educationalAttainments;
  final ValueChanged<List<EducationalAttainment>> onChanged;

  AddEducationalAttainmentWidget({required this.educationalAttainments, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text('Educational Attainments', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorManager.bc5)),
        ...educationalAttainments.map((attainment) => _buildEducationalAttainmentItem(context, attainment)).toList(),
        TextButton(
          onPressed: () {
            educationalAttainments.add(EducationalAttainment());
            onChanged(educationalAttainments);
          },
          child: Text('Add Educational Attainment'),
        ),
      ],
    );
  }

  Widget _buildEducationalAttainmentItem(BuildContext context, EducationalAttainment attainment) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          TextFormField(
            initialValue: attainment.educationalAttainmentLevel,
            decoration: InputDecoration(
              labelText: 'Level',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            onChanged: (value) {
              attainment.educationalAttainmentLevel = value;
              onChanged(educationalAttainments);
            },
          ),
          SizedBox(height: 8),
          TextFormField(
            initialValue: attainment.specialization,
            decoration: InputDecoration(
              labelText: 'Specialization',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            onChanged: (value) {
              attainment.specialization = value;
              onChanged(educationalAttainments);
            },
          ),
          SizedBox(height: 8),
          TextFormField(
            initialValue: attainment.certificate,
            decoration: InputDecoration(
              labelText: 'Certificate',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            onChanged: (value) {
              attainment.certificate = value;
              onChanged(educationalAttainments);
            },
          ),
          SizedBox(height: 8),
          TextFormField(
            initialValue: attainment.graduationRate,
            decoration: InputDecoration(
              labelText: 'Graduation Rate',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            onChanged: (value) {
              attainment.graduationRate = value;
              onChanged(educationalAttainments);
            },
          ),
          SizedBox(height: 8),
          TextFormField(
            initialValue: attainment.academicYear,
            decoration: InputDecoration(
              labelText: 'Academic Year',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            onChanged: (value) {
              attainment.academicYear = value;
              onChanged(educationalAttainments);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              educationalAttainments.remove(attainment);
              onChanged(educationalAttainments);
            },
          ),
        ],
      ),
    );
  }
}
