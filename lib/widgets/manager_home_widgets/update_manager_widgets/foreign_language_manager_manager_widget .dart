import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';
import '../../../models/Pending Model/pending_beneficiary_request_model.dart';

class ForeignLanguageManagerUpdateWidget  extends StatelessWidget {
  final List<ForeignLanguages> foreignLanguages;

  ForeignLanguageManagerUpdateWidget({required this.foreignLanguages});

  @override
  Widget build(BuildContext context) {
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
              AppLocalizations.of(context).translate('foreign_languages'),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: foreignLanguages.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    TextFormField(
                      initialValue: foreignLanguages[index].nameLanguage,
                      decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('language')),
                      onSaved: (value) {
                        foreignLanguages[index].nameLanguage = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: foreignLanguages[index].level,
                      decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('level')),
                      onSaved: (value) {
                        foreignLanguages[index].level = value!;
                      },
                    ),
                    SizedBox(height: 10),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
