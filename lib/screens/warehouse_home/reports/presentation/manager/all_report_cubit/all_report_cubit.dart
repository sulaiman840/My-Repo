import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/report_repo.dart';
import 'all_report_state.dart';


class AllReportCubit extends Cubit<AllReportState> {

  static AllReportCubit get(context) => BlocProvider.of(context);

  AllReportCubit(this.reportRepo) : super(AllReportInitial());

  final ReportRepo reportRepo;
  int afterIncreasePaginate = 50;

  int increasePaginate({required int paginate}){
    afterIncreasePaginate = paginate + 50;
    emit(IncreasePaginateSuccess());
    return afterIncreasePaginate;
  }

  Future<void> fetchAllReports({
    required int paginate,
  }) async {
    emit(AllReportLoading());
    var result = await reportRepo.fetchAllReports(
      paginate: paginate,
    );

    result.fold((failure) {
      emit(AllReportFailure(failure.errorMessage));
    }, (showAllReports) {
      emit(AllReportSuccess(showAllReports));
    },
    );
  }
}