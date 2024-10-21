import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../Bloc/manager/pending_beneficiary_state.dart';
import '../../../models/Pending Model/pending_beneficiary_request_model.dart';
import '../../../widgets/manager_home_widgets/update_manager_widgets/action_buttons_row.dart';
import '../../../widgets/manager_home_widgets/update_manager_widgets/detail_card_manager.dart';
import '../../../Bloc/manager/pending_beneficiary_cubit.dart';
import '../../../widgets/general_widgets/common_scaffold.dart';

class BeneficiaryDetailManagerScreen extends StatefulWidget {
  final DataRequest pendingRequest;

  const BeneficiaryDetailManagerScreen({Key? key, required this.pendingRequest}) : super(key: key);

  @override
  _BeneficiaryDetailManagerScreenState createState() => _BeneficiaryDetailManagerScreenState();
}

class _BeneficiaryDetailManagerScreenState extends State<BeneficiaryDetailManagerScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PendingBeneficiaryCubit>().fetchPendingRequests();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PendingBeneficiaryCubit, PendingBeneficiaryState>(
      builder: (context, state) {
        DataRequest? currentRequest;
        bool isLoading = false;

        if (state is PendingBeneficiaryLoading) {
          isLoading = true;
        } else if (state is PendingBeneficiaryLoaded) {
          currentRequest = state.pendingRequests.firstWhere(
                (req) => req.id == widget.pendingRequest.id,
            orElse: () => widget.pendingRequest,
          );
        }

        return CommonScaffold(
          title: currentRequest?.requsetPending?.name ?? 'Beneficiary Details',
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
                      DetailCard(beneficiary: currentRequest.requsetPending!)
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

  void _approveRequest(BuildContext context, DataRequest? currentRequest) {
    if (currentRequest != null) {
      context.read<PendingBeneficiaryCubit>().approveRequest(currentRequest.id!);
      context.go('/manager_home?tab=3');
    }
  }

  void _rejectRequest(BuildContext context, DataRequest? currentRequest) {
    if (currentRequest != null) {
      context.read<PendingBeneficiaryCubit>().rejectRequest(currentRequest.id!);
      context.go('/manager_home?tab=3');
    }
  }
}
