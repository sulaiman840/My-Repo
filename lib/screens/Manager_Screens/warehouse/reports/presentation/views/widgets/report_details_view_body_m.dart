import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/localization/app_localizations.dart';
import '../../../../../../../core/utils/app_manager.dart';
import '../../../../../../../widgets/custom_snack_bar.dart';
import '../../../../../../warehouse_home/reports/presentation/manager/details_report_cubit/details_report_cubit.dart';
import '../../../../../../warehouse_home/reports/presentation/manager/details_report_cubit/details_report_state.dart';
import '../../../../../../warehouse_home/reports/presentation/manager/get_file_cubit/get_file_cubit.dart';
import '../../../../../../warehouse_home/reports/presentation/manager/get_file_cubit/get_file_state.dart';

class ReportDetailsViewBodyM extends StatelessWidget {
  const ReportDetailsViewBodyM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsReportCubit, DetailsReportState>(
      builder: (context, state) {
        return BlocConsumer<GetFileCubit, GetFileState>(
          listener: (contextGetFile, stateGetFile) {
            if (stateGetFile is GetFileSuccess) {
              CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('get_file_successfully'),);
            } else if (stateGetFile is GetFileFailure) {
              CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('get_file_failed'),);
            }
          },
          builder: (contextGetFile, stateGetFile) {
            if (state is DetailsReportSuccess) {
              final TextEditingController bodyController = TextEditingController(text: state.report.body ?? AppLocalizations.of(context).translate('no_body'));
              return Padding(
                padding: const EdgeInsets.all(AppSize.s16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSize.s16,
                        ),
                        child: Material(
                          borderRadius: const BorderRadiusDirectional.all(
                              Radius.circular(10.0)),
                          color: Colors.grey.shade100,
                          elevation: 2.0,
                          child: SizedBox(
                            height: 400.0,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(AppSize.s16),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context).translate('title'),
                                        style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        state.report.title ?? AppLocalizations.of(context).translate('no_title'),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const Spacer(),
                                      state.report.filePath!.isNotEmpty ? IconButton(
                                        onPressed: () {
                                          GetFileCubit.get(context).fetchFile(
                                            id: state.report.id,
                                            ext: state.report.filePath!.contains('pdf') ? 'pdf'
                                                : state.report.filePath!.contains('docx') ? 'docx'
                                                : state.report.filePath!.contains('txt') ? 'txt'
                                                : state.report.filePath!.contains('jpg') ? 'jpg'
                                                : 'png',
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.download_outlined,
                                        ),
                                      ) : const SizedBox(height: 0, width: 0,),
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                    AppLocalizations.of(context).translate('body'),
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 10.0, width: 0.0,),
                                  TextFormField(
                                    readOnly: true,
                                    textAlign: TextAlign.start,
                                    keyboardType: TextInputType.multiline,
                                    scrollPhysics: const ScrollPhysics(parent: BouncingScrollPhysics(),),
                                    maxLines: 10,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(25)),
                                        borderSide: BorderSide(
                                          color: Colors.black38,
                                          width: 1,
                                        ),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(25)),
                                        borderSide: BorderSide(
                                          color: Colors.black38,
                                          width: 1,
                                        ),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(25)),
                                        borderSide: BorderSide(
                                          color: Colors.black38,
                                          width: 1,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsetsDirectional.only(
                                        start: 10,
                                        end: 10,
                                        top: 15,
                                        bottom: 10,
                                      ),
                                      floatingLabelStyle: TextStyle(
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0
                                    ),
                                    controller: bodyController,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is DetailsReportFailure) {
              return Text(state.errorMessage);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
  }
}
