import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../Bloc/secertary/student/beneficiary_cubit.dart';
import '../../../Bloc/secertary/student/beneficiary_state.dart';
import '../../../Bloc/secertary/student/beneficiary_excel_cubit.dart';
import '../../../Bloc/secertary/student/beneficiary_excel_state.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../models/Secertary Model/beneficiary_model.dart';
import '../../../core/utils/color_manager.dart';
import '../../../widgets/secretary_widgets/trainer_widgets/trainer_header.dart';

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

  void _confirmDelete(BuildContext context, int beneficiaryId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).translate('confirm_delete')),
          content: Text(AppLocalizations.of(context).translate('delete_sure_beneficiary')),
          actions: [
            TextButton(
              child: Text(AppLocalizations.of(context).translate('cancel')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context).translate('delete')),
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
    context.go('/update_beneficiary', extra: {
      'beneficiary': beneficiary,
      'callback': () {
        print("Returned from update screen");
     //   _fetchBeneficiaries();
      },
    });
  }

  void _exportBeneficiaries() {
    context.read<BeneficiaryExcelCubit>().exportToExcel(filters: {"gender": "Male"});
  }

  void _importBeneficiaries() {
    context.read<BeneficiaryExcelCubit>().importFromExcel();
  }

  void _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bc1,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          AppLocalizations.of(context).translate('beneficiary_title'),
          style: TextStyle(fontWeight: FontWeight.bold, color: ColorManager.bc5),
        ),
        centerTitle: true,
        backgroundColor: ColorManager.bc1,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                // decoration: BoxDecoration(
                //   color: ColorManager.blue,
                //   shape: BoxShape.circle,
                // ),
                child: IconButton(
                  icon: const Icon(FontAwesomeIcons.fileImport,color: ColorManager.blue2,size: 27,),
                  onPressed: _importBeneficiaries,
                  tooltip: AppLocalizations.of(context).translate('import'),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                // decoration: BoxDecoration(
                //   color: ColorManager.blue,
                //   shape: BoxShape.circle,
                // ),
                child: IconButton(
                  icon: const Icon(FontAwesomeIcons.fileExport,color: ColorManager.blue2,size: 27),
                  onPressed: _exportBeneficiaries,
                  tooltip: AppLocalizations.of(context).translate('export'),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.blue,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  context.go('/pending_beneficiary');
                  //     .then((_) {
                  //   _fetchBeneficiaries();
                  // });
                },
                tooltip: AppLocalizations.of(context).translate('add_beneficiary_title'),
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
            const SizedBox(height: 10),
            BlocListener<BeneficiaryExcelCubit, BeneficiaryExcelState>(
              listener: (context, state) {
                if (state is BeneficiaryExcelImportSuccess) {
                  _showSnackbar(AppLocalizations.of(context).translate('import_successful'), Colors.green);
                  _fetchBeneficiaries();
                } else if (state is BeneficiaryExcelExportSuccesss) {
                  _showSnackbar(AppLocalizations.of(context).translate('export_successful'), Colors.green);
                  _fetchBeneficiaries();
                } else if (state is BeneficiaryExcelError) {
                  _showSnackbar(state.message, Colors.red);
                }
              },
              child: BlocBuilder<BeneficiaryExcelCubit, BeneficiaryExcelState>(
                builder: (context, state) {
                  if (state is BeneficiaryExcelLoading) {
                    return const LinearProgressIndicator();
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
                builder: (context, state) {
                  if (state is BeneficiaryLoading) {
                    return const Center(child: CircularProgressIndicator());
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
                            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    beneficiary.id?.toString() ?? '',
                                    style: TextStyle(
                                      color: ColorManager.bc5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    beneficiary.name ?? '',
                                    style: TextStyle(
                                      color: ColorManager.bc5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    beneficiary.email ?? '',
                                    style: TextStyle(
                                      color: ColorManager.bc5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    beneficiary.numberPhone ?? '',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: ColorManager.bc5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
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
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    _confirmDelete(context, beneficiary.id!);
                                  },
                                ),
                              ],
                            ),
                            onTap: () {
                              context.go('/beneficiary_detail/${beneficiary.id}');
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
