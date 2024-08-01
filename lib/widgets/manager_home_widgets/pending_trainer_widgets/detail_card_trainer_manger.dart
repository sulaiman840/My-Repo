import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../models/Pending Model/pending_beneficiary_request_model.dart';
import '../../../models/Pending Model/pending_trainer.dart';

import 'detail_item_list_trainer.dart';

class DetailCardTrainerManger extends StatelessWidget {
  final PendingTrainer trainer;

  const DetailCardTrainerManger({Key? key, required this.trainer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailItemListTrainer(trainer: trainer),

          ],
        ),
      ),
    );
  }
}
