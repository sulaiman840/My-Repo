import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/report_repo.dart';
import 'details_report_state.dart';


class DetailsReportCubit extends Cubit<DetailsReportState> {

  static DetailsReportCubit get(context) => BlocProvider.of(context);

  DetailsReportCubit(this.reportRepo) : super(DetailsReportInitial());

  final ReportRepo reportRepo;

  Future<void> fetchReportById({
    required int id,
  }) async {
    emit(DetailsReportLoading());
    var result = await reportRepo.fetchReportById(
      id: id,
    );

    result.fold((failure) {
      emit(DetailsReportFailure(failure.errorMessage));
    }, (showReport) {
      emit(DetailsReportSuccess(showReport));
    },
    );
  }
}