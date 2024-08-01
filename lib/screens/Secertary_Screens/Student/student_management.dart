import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/screens/Secertary_Screens/Student/pending_beneficiary_screen.dart';
import '../../../Bloc/secertary/student/beneficiary_cubit.dart';
import '../../../Bloc/secertary/student/beneficiary_state.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';
import '../../../core/utils/color_manager.dart';
import 'update_beneficiary_dialog.dart';
import 'add_beneficiary_screen.dart';
import 'beneficiary_details_screen.dart';

class BeneficiaryManagementScreen extends StatefulWidget {
  const BeneficiaryManagementScreen({super.key});
  @override
  _BeneficiaryManagementScreenState createState() => _BeneficiaryManagementScreenState();
}

class _BeneficiaryManagementScreenState extends State<BeneficiaryManagementScreen> {
  @override
  void initState() {
    super.initState();
    _fetchBeneficiaries();
  }

  void _fetchBeneficiaries() {
    Future.microtask(() => context.read<BeneficiaryCubit>().fetchBeneficiaries());
  }
  int a=0;

  void _confirmDelete(BuildContext context, int beneficiaryId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this beneficiary?"),
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
                context.read<BeneficiaryCubit>().deleteBeneficiary(beneficiaryId);
                Navigator.of(context).pop();
                _fetchBeneficiaries();
              },
            ),
          ],
        );
      },
    );
  }

  void _showUpdateScreen(BuildContext context, DataBeneficiary beneficiary) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BeneficiaryUpdateScreen(beneficiary: beneficiary),
      ),
    ).then((_) {
      _fetchBeneficiaries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bc1,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Beneficiary Management',
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
                    MaterialPageRoute(builder: (context) => PendingBeneficiaryScreen()),
                  ).then((_) {
                    _fetchBeneficiaries();
                  });
                },
                tooltip: 'Add Beneficiary',
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              decoration: BoxDecoration(
                color: ColorManager.bc2,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Text('ID',
                          style: TextStyle(fontWeight: FontWeight.bold, color: ColorManager.bc5))),
                  Expanded(
                      flex: 3,
                      child: Text('Name',
                          style: TextStyle(fontWeight: FontWeight.bold, color: ColorManager.bc5))),
                  Expanded(
                      flex: 4,
                      child: Text('Email',
                          style: TextStyle(fontWeight: FontWeight.bold, color: ColorManager.bc5))),
                  Expanded(
                      flex: 4,
                      child: Text('Phone',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.bold, color: ColorManager.bc5))),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
                builder: (context, state) {
                  if (state is BeneficiaryLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is BeneficiaryLoaded) {
                    return ListView.builder(
                      itemCount: state.beneficiaries.length,
                      itemBuilder: (context, index) {
                        final beneficiary = state.beneficiaries[index];
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
                                    child: Text(beneficiary.id?.toString() ?? '',
                                        style: TextStyle(color: ColorManager.bc5, fontWeight: FontWeight.w500))),
                                Expanded(
                                    flex: 3,
                                    child: Text(beneficiary.name ?? '',
                                        style: TextStyle(color: ColorManager.bc5, fontWeight: FontWeight.w500))),
                                Expanded(
                                    flex: 4,
                                    child: Text(beneficiary.email ?? '',
                                        style: TextStyle(color: ColorManager.bc5, fontWeight: FontWeight.w500))),
                                Expanded(
                                    flex: 3,
                                    child: Text(beneficiary.numberPhone ?? '',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(color: ColorManager.bc5, fontWeight: FontWeight.w500))),


                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: ColorManager.blue),
                                  onPressed: () {
                                    _showUpdateScreen(context, beneficiary);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    _confirmDelete(context, beneficiary.id!);
                                  },
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BeneficiaryDetailsScreen(
                                    beneficiaryId: beneficiary.id!,
                                  ),
                                ),
                              ).then((_) {
                                _fetchBeneficiaries();
                              });
                            },
                          ),
                        );
                      },
                    );
                  } else if (state is BeneficiaryError) {
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
