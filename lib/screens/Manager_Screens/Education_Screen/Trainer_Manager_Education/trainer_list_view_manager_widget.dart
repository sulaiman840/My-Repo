import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/color_manager.dart';
import '../../../../../models/Secertary Model/trainer_model.dart';

class TrainerListViewManagerWidget extends StatelessWidget {
  final List<Trainer> trainers;
  final Function(int) onTap;

  const TrainerListViewManagerWidget({
    required this.trainers,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: trainers.length,
      itemBuilder: (context, index) {
        final trainer = trainers[index];
        return Card(
          color: ColorManager.bc2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            title: Row(
              children: [
                Expanded(
                    child: Text(trainer.id?.toString() ?? '',
                        style: TextStyle(color: ColorManager.bc5, fontWeight: FontWeight.w500))),
                Expanded(
                    flex: 3,
                    child: Text(trainer.name ?? '',
                        style: TextStyle(color: ColorManager.bc5, fontWeight: FontWeight.w500))),
                Expanded(
                    flex: 4,
                    child: Text(trainer.email ?? '',
                        style: TextStyle(color: ColorManager.bc5, fontWeight: FontWeight.w500))),
                Expanded(
                    flex: 3,
                    child: Text(trainer.phone ?? '',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: ColorManager.bc5, fontWeight: FontWeight.w500))),
              ],
            ),
            onTap: () => onTap(trainer.id!),
          ),
        );
      },
    );
  }
}
