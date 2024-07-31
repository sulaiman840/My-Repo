import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/screens/Manager_Screens/Education_Screen/Trainer_Manager_Education/trainer_details_education_screen.dart';
import 'package:project2/screens/Manager_Screens/Education_Screen/Trainer_Manager_Education/trainer_list_view_manager_widget.dart';
import '../../../../Bloc/secertary/trainer/trainer_cubit.dart';
import '../../../../Bloc/secertary/trainer/trainer_state.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../widgets/general_widgets/common_scaffold.dart';
import '../../../../widgets/secretary_widgets/trainer_widgets/trainer_header.dart';


class TrainersEducationScreen extends StatefulWidget {
  const TrainersEducationScreen({super.key});

  @override
  _TrainersEducationScreenState createState() => _TrainersEducationScreenState();
}

class _TrainersEducationScreenState extends State<TrainersEducationScreen> {
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
    return CommonScaffold(
      title: 'Trainer Education',
      scaffoldKey: GlobalKey<ScaffoldState>(),
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
                    return TrainerListViewManagerWidget(
                      trainers: state.trainers,
                      onTap: (id) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TrainerDetailsEducationScreen(trainerId: id),
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
}
