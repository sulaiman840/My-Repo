import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/color_manager.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';

class AddForeignLanguageWidget extends StatefulWidget {
  final ValueNotifier<List<ForeignLanguage>> foreignLanguagesNotifier;

  AddForeignLanguageWidget({
    required List<ForeignLanguage> foreignLanguages,
  }) : foreignLanguagesNotifier = ValueNotifier(foreignLanguages);

  @override
  _AddForeignLanguageWidgetState createState() => _AddForeignLanguageWidgetState();
}

class _AddForeignLanguageWidgetState extends State<AddForeignLanguageWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<ForeignLanguage>>(
      valueListenable: widget.foreignLanguagesNotifier,
      builder: (context, foreignLanguages, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              AppLocalizations.of(context).translate('foreign_languages'),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorManager.bc5,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: foreignLanguages.length,
              itemBuilder: (context, index) {
                return _buildForeignLanguageItem(context, foreignLanguages[index]);
              },
            ),
            TextButton(
              onPressed: () {
                final newLanguage = ForeignLanguage();
                widget.foreignLanguagesNotifier.value = [
                  ...foreignLanguages,
                  newLanguage,
                ];
              },
              child: Text(AppLocalizations.of(context).translate('add_foreign_language')),
            ),
            if (foreignLanguages.isEmpty)
              Text(
                AppLocalizations.of(context).translate('no_foreign_languages_added'),
                style: TextStyle(fontSize: 16),
              ),
          ],
        );
      },
    );
  }

  Widget _buildForeignLanguageItem(BuildContext context, ForeignLanguage language) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          _buildTextFormField(
            context,
            label: AppLocalizations.of(context).translate('language_name'),
            initialValue: language.nameLanguage ?? '',
            onChanged: (value) {
              language.nameLanguage = value;
            },
          ),
          SizedBox(height: 8),
          _buildTextFormField(
            context,
            label: AppLocalizations.of(context).translate('level'),
            initialValue: language.level ?? '',
            onChanged: (value) {
              language.level = value;
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              widget.foreignLanguagesNotifier.value = [
                ...widget.foreignLanguagesNotifier.value..remove(language),
              ];
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField(BuildContext context, {required String label, required String initialValue, required ValueChanged<String> onChanged}) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      onChanged: onChanged,
    );
  }
}
