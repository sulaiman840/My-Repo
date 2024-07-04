import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/staff_repo.dart';
import 'staff_details_state.dart';

class StaffDetailsCubit extends Cubit<StaffDetailsState> {

  static StaffDetailsCubit get(context) => BlocProvider.of(context);
  StaffDetailsCubit(this.staffRepo) : super(StaffDetailsInitial());

  final StaffRepo staffRepo;

  Future<void> fetchStaffDetails({
  required int id,
}) async {
    emit(StaffDetailsInitial());
    var result = await staffRepo.fetchShowStaffDetails(id: id);
    result.fold((failure) {
      emit(StaffDetailsFailure(failure.errorMessage));
    }, (showStaff) {
      emit(StaffDetailsSuccess(showStaff));
    }
    );
  }
}