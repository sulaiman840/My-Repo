import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/color_manager.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';

class AddDisabilityWidget extends StatelessWidget {
  final String title;
  final List<Disability> disabilities;
  final ValueChanged<List<Disability>> onChanged;

  AddDisabilityWidget({required this.title, required this.disabilities, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorManager.bc5)),
        ...disabilities.map((disability) => _buildDisabilityItem(context, disability)).toList(),
        TextButton(
          onPressed: () {
            disabilities.add(Disability());
            onChanged(disabilities);
          },
          child: Text('Add Disability'),
        ),
      ],
    );
  }

  Widget _buildDisabilityItem(BuildContext context, Disability disability) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              initialValue: disability.nameDisability,
              decoration: InputDecoration(
                labelText: 'Disability Name',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              onChanged: (value) {
                disability.nameDisability = value;
                onChanged(disabilities);
              },
            ),
          ),
          SizedBox(width: 8),
          if (title != "Family Member Disabilities")
            Expanded(
              child: TextFormField(
                initialValue: disability.rateDisability,
                decoration: InputDecoration(
                  labelText: 'Disability Rate',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                onChanged: (value) {
                  disability.rateDisability = value;
                  onChanged(disabilities);
                },
              ),
            ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              disabilities.remove(disability);
              onChanged(disabilities);
            },
          ),
        ],
      ),
    );
  }
}
