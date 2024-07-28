import 'package:flutter/cupertino.dart';

import '../../../core/utils/color_manager.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';

class DisplayForeignLanguageWidget extends StatelessWidget {
  final List<ForeignLanguage> foreignLanguages;

  DisplayForeignLanguageWidget({required this.foreignLanguages});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: foreignLanguages.map((language) => _buildForeignLanguageItem(context, language)).toList(),
    );
  }

  Widget _buildForeignLanguageItem(BuildContext context, ForeignLanguage language) {
    return Container(
      width: MediaQuery.of(context).size.width / 3 - 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(language.nameLanguage ?? '', style: TextStyle(fontSize: 16, color: ColorManager.bc4)),
          Text(language.level ?? '', style: TextStyle(fontSize: 16, color: ColorManager.bc4)),
        ],
      ),
    );
  }
}
