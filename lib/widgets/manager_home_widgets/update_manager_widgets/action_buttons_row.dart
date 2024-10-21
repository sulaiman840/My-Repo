import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/localization/app_localizations.dart';

class ActionButtonsRow extends StatelessWidget {
  final VoidCallback onApprove;
  final VoidCallback onReject;
  final VoidCallback? onEdit;

  const ActionButtonsRow({
    Key? key,
    required this.onApprove,
    required this.onReject,
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: onApprove,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(AppLocalizations.of(context).translate('approve'), style: TextStyle(fontSize: 16, color: Colors.white)),
        ),
        SizedBox(width: 20),
        ElevatedButton(
          onPressed: onReject,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(AppLocalizations.of(context).translate('reject'), style: TextStyle(fontSize: 16, color: Colors.white)),
        ),
        Spacer(),
        if(onEdit!=null)
        ElevatedButton(
          onPressed: onEdit,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(AppLocalizations.of(context).translate('edit'), style: TextStyle(fontSize: 16, color: Colors.white)),
        ),
      ],
    );
  }
}
