import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../models/Secertary Model/trainer_model.dart';

class TrainerListView extends StatelessWidget {
  final List<Trainer> trainers;
  final Function(Trainer) onUpdate;
  final Function(int) onDelete;
  final Function(int) onTap;

  const TrainerListView({
    required this.trainers,
    required this.onUpdate,
    required this.onDelete,
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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: ColorManager.blue),
                  onPressed: () => onUpdate(trainer),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => onDelete(trainer.id!),
                ),
              ],
            ),
            onTap: () => onTap(trainer.id!),
          ),
        );
      },
    );
  }
}
