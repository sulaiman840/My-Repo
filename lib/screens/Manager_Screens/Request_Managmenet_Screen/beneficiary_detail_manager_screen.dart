// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../Bloc/manager/pending_beneficiary_state.dart';
// import '../../../models/pending_beneficiary_request_model.dart';
// import '../../../widgets/manager_home_widgets/update_manager_widgets/action_buttons_row.dart';
// import '../../../widgets/manager_home_widgets/update_manager_widgets/detail_card_manager.dart';
// import 'beneficiary_edit_manager_screen.dart';
// import '../../../Bloc/manager/pending_beneficiary_cubit.dart';
// import '../../../widgets/general_widgets/common_scaffold.dart';
//
// class BeneficiaryDetailManagerScreen extends StatefulWidget {
//   final DataRequest pendingRequest;
//
//   const BeneficiaryDetailManagerScreen({Key? key, required this.pendingRequest}) : super(key: key);
//
//   @override
//   _BeneficiaryDetailManagerScreenState createState() => _BeneficiaryDetailManagerScreenState();
// }
//
// class _BeneficiaryDetailManagerScreenState extends State<BeneficiaryDetailManagerScreen> {
//   late DataRequest currentRequest;
//
//   @override
//   void initState() {
//     super.initState();
//     currentRequest = widget.pendingRequest;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<PendingBeneficiaryCubit, PendingBeneficiaryState>(
//       listener: (context, state) {
//         if (state is PendingBeneficiaryLoaded) {
//           final updatedRequest = state.pendingRequests.firstWhere(
//                 (req) => req.id == currentRequest.id,
//             orElse: () => currentRequest,
//           );
//           setState(() {
//             currentRequest = updatedRequest;
//           });
//         }
//       },
//       child: CommonScaffold(
//         title: currentRequest.requsetPending?.name ?? 'Beneficiary Details',
//         scaffoldKey: GlobalKey<ScaffoldState>(),
//         body: LayoutBuilder(
//           builder: (context, constraints) {
//             return SingleChildScrollView(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ActionButtonsRow(
//                     onApprove: () => _approveRequest(context),
//                     onReject: () => _rejectRequest(context),
//                     onEdit: () => _navigateToEditScreen(context, currentRequest.requsetPending!, currentRequest),
//                   ),
//                   SizedBox(height: 16),
//                   DetailCard(
//                     beneficiary: currentRequest.requsetPending!,
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   void _approveRequest(BuildContext context) {
//     context.read<PendingBeneficiaryCubit>().approveRequest(currentRequest.id!);
//     Navigator.pop(context);
//   }
//
//   void _rejectRequest(BuildContext context) {
//     context.read<PendingBeneficiaryCubit>().rejectRequest(currentRequest.id!);
//     Navigator.pop(context);
//   }
//
//   void _navigateToEditScreen(BuildContext context, RequsetPending beneficiary, DataRequest hh) async {
//     final updated = await Navigator.of(context).push(MaterialPageRoute(
//       builder: (context) => BeneficiaryEditManagerScreen(beneficiary: beneficiary, hh: hh),
//     ));
//
//     if (updated == true) {
//       await context.read<PendingBeneficiaryCubit>().fetchPendingRequests();
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc/manager/pending_beneficiary_state.dart';
import '../../../models/Pending Model/pending_beneficiary_request_model.dart';
import '../../../widgets/manager_home_widgets/update_manager_widgets/action_buttons_row.dart';
import '../../../widgets/manager_home_widgets/update_manager_widgets/detail_card_manager.dart';
import 'beneficiary_edit_manager_screen.dart';
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
                      onEdit: () => _navigateToEditScreen(context, currentRequest?.requsetPending, currentRequest),
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
      Navigator.pop(context);
    }
  }

  void _rejectRequest(BuildContext context, DataRequest? currentRequest) {
    if (currentRequest != null) {
      context.read<PendingBeneficiaryCubit>().rejectRequest(currentRequest.id!);
      Navigator.pop(context);
    }
  }

  void _navigateToEditScreen(BuildContext context, RequsetPending? beneficiary, DataRequest? hh) async {
    if (beneficiary != null && hh != null) {
      final updated = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BeneficiaryEditManagerScreen(beneficiary: beneficiary, hh: hh),
      ));

      if (updated == true) {
        context.read<PendingBeneficiaryCubit>().fetchPendingRequests();
      }
    }
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../Bloc/manager/pending_beneficiary_state.dart';
// import '../../../models/pending_beneficiary_request_model.dart';
// import '../../../widgets/manager_home_widgets/update_manager_widgets/action_buttons_row.dart';
// import '../../../widgets/manager_home_widgets/update_manager_widgets/detail_card_manager.dart';
// import 'beneficiary_edit_manager_screen.dart';
// import '../../../Bloc/manager/pending_beneficiary_cubit.dart';
// import '../../../widgets/general_widgets/common_scaffold.dart';
//
// class BeneficiaryDetailManagerScreen extends StatelessWidget {
//   final DataRequest pendingRequest;
//
//   const BeneficiaryDetailManagerScreen({Key? key, required this.pendingRequest}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PendingBeneficiaryCubit, PendingBeneficiaryState>(
//       builder: (context, state) {
//         DataRequest? currentRequest = pendingRequest;
//         bool isLoading = false;
//
//         if (state is PendingBeneficiaryLoading) {
//           isLoading = true;
//         } else if (state is PendingBeneficiaryLoaded) {
//           currentRequest = state.pendingRequests.firstWhere(
//                 (req) => req.id == pendingRequest.id,
//             orElse: () => pendingRequest,
//           );
//         }
//
//         return CommonScaffold(
//           title: currentRequest?.requsetPending?.name ?? 'Beneficiary Details',
//           scaffoldKey: GlobalKey<ScaffoldState>(),
//           body: LayoutBuilder(
//             builder: (context, constraints) {
//               return SingleChildScrollView(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ActionButtonsRow(
//                       onApprove: () => _approveRequest(context, currentRequest),
//                       onReject: () => _rejectRequest(context, currentRequest),
//                       onEdit: () => _navigateToEditScreen(context, currentRequest?.requsetPending, currentRequest),
//                     ),
//                     SizedBox(height: 16),
//                     if (isLoading)
//                       Center(child: CircularProgressIndicator())
//                     else if (currentRequest != null)
//                       DetailCard(beneficiary: currentRequest.requsetPending!)
//                     else
//                       Center(child: Text('No data available')),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
//
//   void _approveRequest(BuildContext context, DataRequest? currentRequest) {
//     if (currentRequest != null) {
//       context.read<PendingBeneficiaryCubit>().approveRequest(currentRequest.id!);
//       Navigator.pop(context);
//     }
//   }
//
//   void _rejectRequest(BuildContext context, DataRequest? currentRequest) {
//     if (currentRequest != null) {
//       context.read<PendingBeneficiaryCubit>().rejectRequest(currentRequest.id!);
//       Navigator.pop(context);
//     }
//   }
//
//   void _navigateToEditScreen(BuildContext context, RequsetPending? beneficiary, DataRequest? hh) async {
//     if (beneficiary != null && hh != null) {
//       final updated = await Navigator.of(context).push(MaterialPageRoute(
//         builder: (context) => BeneficiaryEditManagerScreen(beneficiary: beneficiary, hh: hh),
//       ));
//
//       if (updated == true) {
//         context.read<PendingBeneficiaryCubit>().fetchPendingRequests();
//       }
//     }
//   }
// }
