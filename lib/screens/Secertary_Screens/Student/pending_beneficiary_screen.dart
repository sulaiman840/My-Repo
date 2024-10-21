import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project2/screens/Secertary_Screens/Student/add_beneficiary_screen.dart';
import '../../../Bloc/manager/pending_beneficiary_cubit.dart';
import '../../../Bloc/manager/pending_beneficiary_state.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/color_manager.dart';
import '../../../widgets/general_widgets/common_scaffold.dart';

class PendingBeneficiaryScreen extends StatefulWidget {
  const PendingBeneficiaryScreen({super.key});

  @override
  _PendingBeneficiaryScreenState createState() => _PendingBeneficiaryScreenState();
}

class _PendingBeneficiaryScreenState extends State<PendingBeneficiaryScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _fetchPendingRequests();
  }

  void _fetchPendingRequests() {
    context.read<PendingBeneficiaryCubit>().fetchPendingRequests();
  }

  void _navigateToCreateBeneficiaryScreen() {
    context.go('/add_beneficiary', extra: {
      'callback': () {
        print("Returned from add screen");
        //   _fetchBeneficiaries();
      },
    });

  }
  // void _navigateToCreateBeneficiaryScreen() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => BeneficiaryCreateScreen(onBeneficiaryAdded: _fetchPendingRequests)),
  //   ).then((_) {
  //     _fetchPendingRequests();
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: AppLocalizations.of(context).translate('pending_beneficiary_requests'),
      scaffoldKey: _scaffoldKey,
      body: Column(
        children: [
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
              onPressed: _navigateToCreateBeneficiaryScreen,
              child: Text(
                AppLocalizations.of(context).translate('create_new_beneficiary'),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<PendingBeneficiaryCubit, PendingBeneficiaryState>(
                builder: (context, state) {
                  if (state is PendingBeneficiaryLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is PendingBeneficiaryLoaded) {
                    return ListView.builder(
                      itemCount: state.pendingRequests.length,
                      itemBuilder: (context, index) {
                        final pendingRequest = state.pendingRequests[index];
                        final beneficiary = pendingRequest.requsetPending;
                        return Card(
                          color: ColorManager.bc2,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          elevation: 4,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: ColorManager.bc3,
                              child: Text(
                                beneficiary!.name![0],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(
                              beneficiary.name!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${AppLocalizations.of(context).translate('email')}: ${beneficiary.email}',
                                  style: TextStyle(color: ColorManager.bc4),
                                ),
                                Text(
                                  '${AppLocalizations.of(context).translate('status')}: ${pendingRequest.status}',
                                  style: TextStyle(color: ColorManager.bc3),
                                ),
                              ],
                            ),
                            trailing: Icon(
                              Icons.circle,
                              color: Colors.grey,
                              size: 12,
                            ),
                            onTap: () {
                              // Implement further actions if needed
                            },
                          ),
                        );
                      },
                    );
                  } else if (state is PendingBeneficiaryError) {
                    return Center(child: Text(state.message));
                  } else {
                    return Container(); // Empty container for other states
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
