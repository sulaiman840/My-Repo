import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../models/Pending Model/pending_beneficiary_request_model.dart';
import '../../../models/Pending Model/pending_trainer.dart';
import '../../secretary_widgets/details_beneficiary_widgets/detail_item_widget.dart';

class DetailItemListTrainer extends StatelessWidget {
  final PendingTrainer trainer;

  const DetailItemListTrainer({Key? key, required this.trainer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: [
        DetailItem(icon: Icons.person, label: AppLocalizations.of(context).translate('name'), value: trainer.name ?? 'N/A'),

        DetailItem(icon: Icons.home, label: AppLocalizations.of(context).translate('address'), value: trainer.address ?? 'N/A'),
        DetailItem(icon: Icons.email, label: AppLocalizations.of(context).translate('email'), value: trainer.email ?? 'N/A'),
        DetailItem(icon: Icons.phone, label: AppLocalizations.of(context).translate('number_phone'), value: trainer.phone ?? 'N/A'),
        DetailItem(icon: Icons.notes, label: AppLocalizations.of(context).translate('type'), value: trainer.type ?? 'N/A'),
        DetailItem(icon: Icons.notes, label: AppLocalizations.of(context).translate('specialty'), value: trainer.specialty ?? 'N/A'),
        DetailItem(icon: Icons.notes, label: AppLocalizations.of(context).translate('description'), value: trainer.description ?? 'N/A'),
      ],
    );
  }
}
