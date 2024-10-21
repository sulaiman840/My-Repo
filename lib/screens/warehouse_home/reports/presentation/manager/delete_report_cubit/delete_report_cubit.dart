import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/report_repo.dart';
import 'delete_report_state.dart';

class DeleteReportCubit extends Cubit<DeleteReportState> {

  static DeleteReportCubit get(context) => BlocProvider.of(context);

  DeleteReportCubit(this.reportRepo) : super(DeleteReportInitial());

  final ReportRepo reportRepo;

  Future<void> fetchDeleteReport({
    required int id,
  }) async {
    emit(DeleteReportLoading());
    var result = await reportRepo.fetchDeleteReport(
      id: id,
    );

    result.fold((failure) {
      emit(DeleteReportFailure(failure.errorMessage));
    }, (deleteReport) {
      emit(DeleteReportSuccess(deleteReport));
    },
    );
  }
}