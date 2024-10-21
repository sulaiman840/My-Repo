import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../Bloc/secertary/trainer/trainer_cubit.dart';
import '../../../../Bloc/secertary/trainer/trainer_state.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../widgets/general_widgets/common_scaffold.dart';
import '../../../../widgets/secretary_widgets/trainer_widgets/trainer_header.dart';
import 'trainer_list_view_manager_widget.dart';

class TrainersEducationScreen extends StatefulWidget {
  const TrainersEducationScreen({super.key});

  @override
  _TrainersEducationScreenState createState() => _TrainersEducationScreenState();
}

class _TrainersEducationScreenState extends State<TrainersEducationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TrainerCubit>().fetchTrainers();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: AppLocalizations.of(context).translate('trainer_education'),
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
                        context.go('/trainer_detail_education/$id');
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
