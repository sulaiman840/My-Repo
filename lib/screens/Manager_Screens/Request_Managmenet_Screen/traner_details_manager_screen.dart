
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc/manager/pending_beneficiary_state.dart';
import '../../../Bloc/manager/pending_trainer_cubit.dart';
import '../../../Bloc/manager/pending_trainer_state.dart';
import '../../../models/Pending Model/pending_beneficiary_request_model.dart';
import '../../../models/Pending Model/pending_trainer.dart';
import '../../../widgets/manager_home_widgets/pending_trainer_widgets/detail_card_trainer_manger.dart';
import '../../../widgets/manager_home_widgets/update_manager_widgets/action_buttons_row.dart';
import '../../../widgets/manager_home_widgets/update_manager_widgets/detail_card_manager.dart';
import 'beneficiary_edit_manager_screen.dart';
import '../../../Bloc/manager/pending_beneficiary_cubit.dart';
import '../../../widgets/general_widgets/common_scaffold.dart';

class TranerDetailsManagerScreen extends StatefulWidget {
  final PendingTrainer pendingTrainer;

  const TranerDetailsManagerScreen({Key? key, required this.pendingTrainer}) : super(key: key);

  @override
  _TranerDetailsManagerScreenState createState() => _TranerDetailsManagerScreenState();
}

class _TranerDetailsManagerScreenState extends State<TranerDetailsManagerScreen> {
  @override
  void initState() {
    super.initState();

    context.read<PendingTrainerCubit>().fetchPendingTrainers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PendingTrainerCubit, PendingTrainerState>(
      builder: (context, state) {
        PendingTrainer? currentRequest;
        bool isLoading = false;

        if (state is PendingTrainerLoading) {
          isLoading = true;
        } else if (state is PendingTrainerLoaded) {
          currentRequest = state.pendingTrainers.firstWhere(
                (req) => req.id == widget.pendingTrainer.id,
            orElse: () => widget.pendingTrainer,
          );
        }

        return CommonScaffold(
          title: currentRequest?.name ?? 'Trainer Details',
          scaffoldKey: GlobalKey<ScaffoldState>(),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ActionButtonsRow(
                      onApprove: () => _approveRequest(context, currentRequest),
                      onReject: () => _rejectRequest(context, currentRequest),

                    ),
                    SizedBox(height: 16),
                    if (isLoading)
                      Center(child: CircularProgressIndicator())
                    else if (currentRequest != null)
                      DetailCardTrainerManger(trainer: currentRequest)
                    else
                      Center(child: Text('No data available')),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _approveRequest(BuildContext context, PendingTrainer? currentRequest) {
    if (currentRequest != null) {
      context.read<PendingTrainerCubit>().approveRequest(currentRequest.id!);
      Navigator.pop(context);
    }
  }

  void _rejectRequest(BuildContext context, PendingTrainer? currentRequest) {
    if (currentRequest != null) {
      context.read<PendingTrainerCubit>().rejectRequest(currentRequest.id!);
      Navigator.pop(context);
    }
  }

}
