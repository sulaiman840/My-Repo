import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';
import '../../../models/Pending Model/pending_beneficiary_request_model.dart';

class DisabilityManagerUpdateWidget extends StatelessWidget {
  final String title;
  final List<Disabilities> disabilities;

  DisabilityManagerUpdateWidget({required this.title, required this.disabilities});

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
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: disabilities.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    TextFormField(
                      initialValue: disabilities[index].nameDisability,
                      decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('disability_name')),
                      onSaved: (value) {
                        disabilities[index].nameDisability = value!;
                      },
                    ),
                    if (title != AppLocalizations.of(context).translate('family_member_disabilities'))
                      TextFormField(
                        initialValue: disabilities[index].rateDisability,
                        decoration: InputDecoration(labelText: AppLocalizations.of(context).translate('disability_rate')),
                        onSaved: (value) {
                          disabilities[index].rateDisability = value!;
                        },
                      ),
                    SizedBox(height: 10),
                  ],
                );
              },
            ),
            if (disabilities.isEmpty)
              Text(
                AppLocalizations.of(context).translate('no_disabilities_added'),
                style: TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
