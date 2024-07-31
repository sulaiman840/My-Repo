import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/screens/Secertary_Screens/Trainer/pending_trainer_screen.dart';
import '../../../Bloc/secertary/trainer/trainer_cubit.dart';
import '../../../Bloc/secertary/trainer/trainer_state.dart';
import '../../../models/Secertary Model/trainer_model.dart';
import '../../../core/utils/color_manager.dart';
import '../../../widgets/secretary_widgets/trainer_widgets/trainer_header.dart';
import '../../../widgets/secretary_widgets/trainer_widgets/trainer_list_view.dart';
import '../../../widgets/secretary_widgets/trainer_widgets/update_trainer_dialog.dart';
import 'trainer_details.dart';

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
      appBar:  AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Trainer Management',
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PendingTrainerScreen(),
                    ),
                  );
                },
                tooltip: 'Add Trainer',
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TrainerDetailsScreen(trainerId: id),
                          ),
                        ).then((_) => _fetchTrainers());
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
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this trainer?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete"),
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
