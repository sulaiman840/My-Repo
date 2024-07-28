import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/color_manager.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';

class AddForeignLanguageWidget extends StatelessWidget {
  final List<ForeignLanguage> foreignLanguages;
  final ValueChanged<List<ForeignLanguage>> onChanged;

  AddForeignLanguageWidget({required this.foreignLanguages, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text('Foreign Languages', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorManager.bc5)),
        ...foreignLanguages.map((language) => _buildForeignLanguageItem(context, language)).toList(),
        TextButton(
          onPressed: () {
            foreignLanguages.add(ForeignLanguage());
            onChanged(foreignLanguages);
          },
          child: Text('Add Foreign Language'),
        ),
      ],
    );
  }

  Widget _buildForeignLanguageItem(BuildContext context, ForeignLanguage language) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          TextFormField(
            initialValue: language.nameLanguage,
            decoration: InputDecoration(
              labelText: 'Language Name',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            onChanged: (value) {
              language.nameLanguage = value;
              onChanged(foreignLanguages);
            },
          ),
          SizedBox(height: 8),
          TextFormField(
            initialValue: language.level,
            decoration: InputDecoration(
              labelText: 'Level',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            onChanged: (value) {
              language.level = value;
              onChanged(foreignLanguages);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              foreignLanguages.remove(language);
              onChanged(foreignLanguages);
            },
          ),
        ],
      ),
    );
  }
}
