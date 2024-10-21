import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../Bloc/secertary/trainer/trainer_cubit.dart';
import '../../../Bloc/secertary/trainer/trainer_state.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../models/Secertary Model/trainer_model.dart';
import '../../../core/utils/color_manager.dart';
import '../../../widgets/secretary_widgets/trainer_widgets/trainer_header.dart';
import '../../../widgets/secretary_widgets/trainer_widgets/trainer_list_view.dart';
import '../../../widgets/secretary_widgets/trainer_widgets/update_trainer_dialog.dart';

class TrainerManagementScreen extends StatefulWidget {
  const TrainerManagementScreen({super.key});

  @override
  _TrainerManagementScreenState createState() => _TrainerManagementScreenState();
}

class _TrainerManagementScreenState extends State<TrainerManagementScreen> {
  @override
  void initState() {
    super.initState();
    _fetchTrainers();
  }

  void _fetchTrainers() {
    if (context.read<TrainerCubit>().state is! TrainerLoaded) {
      Future.microtask(() => context.read<TrainerCubit>().fetchTrainers());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bc1,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          AppLocalizations.of(context).translate('trainer_title'),
          style: TextStyle(fontWeight: FontWeight.bold, color: ColorManager.bc5),
        ),
        centerTitle: true,
        backgroundColor: ColorManager.bc1,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.blue,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  context.go('/pending_trainer');
                },
                tooltip: AppLocalizations.of(context).translate('add_trainer'),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const TrainerHeader(),
            SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<TrainerCubit, TrainerState>(
                builder: (context, state) {
                  if (state is TrainerLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is TrainerLoaded) {
                    return TrainerListView(
                      trainers: state.trainers,
                      onUpdate: (trainer) => _showUpdateDialog(context, trainer),
                      onDelete: (id) => _confirmDelete(context, id),
                      onTap: (id) {
                        context.go('/trainer_detail/$id');
                      },
                    );
                  } else if (state is TrainerError) {
                    return Center(child: Text(state.message));
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, int trainerId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).translate('confirm_delete')),
          content: Text(AppLocalizations.of(context).translate('delete_sure')),
          actions: [
            TextButton(
              child: Text(AppLocalizations.of(context).translate('cancel')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context).translate('delete')),
              onPressed: () {
                context.read<TrainerCubit>().deleteTrainer(trainerId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showUpdateDialog(BuildContext context, Trainer trainer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return UpdateTrainerDialog(trainer: trainer);
      },
    );
  }
}
