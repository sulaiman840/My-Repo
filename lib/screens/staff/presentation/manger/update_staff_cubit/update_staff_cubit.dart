import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/staff_repo.dart';
import 'update_staff_state.dart';

class UpdateStaffCubit extends Cubit<UpdateStaffState> {

  static UpdateStaffCubit get(context) => BlocProvider.of(context);
  UpdateStaffCubit(this.staffRepo,) : super(UpdateStaffInitial());

  final StaffRepo staffRepo;

  IconData suffixIcon = Icons.visibility_off;
  bool isPassShow = true;

  void changePassVisibility() {
    isPassShow = !isPassShow;
    suffixIcon = isPassShow ? Icons.visibility_off : Icons.visibility;
    emit(ChangePassVisibilityState());
  }

  Future<void> fetchUpdateStaff({
    required int id,
    required String name,
    required String email,
    required String number,
    required String password,
    required Uint8List imageBytes,
    required String role,
  }) async {
    emit(UpdateStaffLoading());
    var result = await staffRepo.fetchUpdateStaff(
      id: id,
      name: name,
      email: email,
      password: password,
      number: number,
      imageBytes: imageBytes,
      role: role,
    );

    result.fold((failure) {
      print(failure.errorMessage);
      emit(UpdateStaffFailure(failure.errorMessage));
    }, (createStaff) {
      emit(UpdateStaffSuccess(createStaff));
    },
    );
  }
}
