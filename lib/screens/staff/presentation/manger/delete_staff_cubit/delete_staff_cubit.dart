import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/staff_repo.dart';
import 'delete_staff_state.dart';

class DeleteStaffCubit extends Cubit<DeleteStaffState> {

  static DeleteStaffCubit get(context) => BlocProvider.of(context);
  DeleteStaffCubit(this.staffRepo,) : super(DeleteStaffInitial());

  final StaffRepo staffRepo;

  Future<void> fetchDeleteStaff({
    required int id,
}) async {
    emit(DeleteStaffInitial());
    var result = await staffRepo.fetchDeleteStaff(id: id);
    result.fold((failure) {
      emit(DeleteStaffFailure(failure.errorMessage));
    }, (deleteStaff) {
      emit(DeleteStaffSuccess(deleteStaff));
    }
    );
  }
}