import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Bloc/secertary/student/beneficiary_cubit.dart';
import '../../../../Bloc/secertary/student/beneficiary_state.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../models/Secertary Model/beneficiary_model.dart';
import '../../../../widgets/general_widgets/common_scaffold.dart';

import 'beneficiary_details_education_screen.dart';

class BeneficiariesEducationScreen extends StatefulWidget {
  const BeneficiariesEducationScreen({super.key});

  @override
  _BeneficiariesEducationScreenState createState() => _BeneficiariesEducationScreenState();
}

class _BeneficiariesEducationScreenState extends State<BeneficiariesEducationScreen> {
  @override
  void initState() {
    super.initState();
    _fetchBeneficiaries();
  }

  void _fetchBeneficiaries() {
    Future.microtask(() => context.read<BeneficiaryCubit>().fetchBeneficiaries());
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: 'Beneficiary Education',
      scaffoldKey: GlobalKey<ScaffoldState>(),
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BeneficiaryDetailsEducationScreen(
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
