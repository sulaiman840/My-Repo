import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Bloc/secertary/student/beneficiary_cubit.dart';
import '../../../Bloc/secertary/student/beneficiary_state.dart';
import '../../../Bloc/secertary/student/document_cubit.dart';
import '../../../core/utils/color_manager.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';
import '../../../services/Secertary Services/beneficiary_service.dart';

import '../../../widgets/general_widgets/common_scaffold.dart';
import '../../../widgets/secretary_widgets/details_beneficiary_widgets/beneficiary_details.dart';
import '../../../widgets/secretary_widgets/details_beneficiary_widgets/document_section.dart';

class BeneficiaryDetailsScreen extends StatefulWidget {
  final int beneficiaryId;

  BeneficiaryDetailsScreen({required this.beneficiaryId});

  @override
  _BeneficiaryDetailsScreenState createState() => _BeneficiaryDetailsScreenState();
}

class _BeneficiaryDetailsScreenState extends State<BeneficiaryDetailsScreen> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    context.read<BeneficiaryCubit>().fetchBeneficiaryDetails(widget.beneficiaryId);
    context.read<DocumentCubit>().fetchDocuments(widget.beneficiaryId);
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: 'Beneficiary Details',
      scaffoldKey: GlobalKey<ScaffoldState>(),
      body: BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
        builder: (context, state) {
          if (state is BeneficiaryLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BeneficiaryDetailsLoaded) {
            final beneficiary = state.beneficiary;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BeneficiaryDetails(beneficiary: beneficiary),
                  DocumentSection(
                    beneficiaryId: widget.beneficiaryId,
                    onDocumentsUpdated: _fetchData,
                  ),
                ],
              ),
            );
          } else if (state is BeneficiaryError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('Unknown error'));
          }
        },
      ),
    );
  }
}
