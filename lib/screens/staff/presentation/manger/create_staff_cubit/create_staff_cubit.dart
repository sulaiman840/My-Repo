import 'dart:developer';

import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/staff_repo.dart';
import 'create_staff_state.dart';

class CreateStaffCubit extends Cubit<CreateStaffState> {

  static CreateStaffCubit get(context) => BlocProvider.of(context);
  CreateStaffCubit(this.staffRepo,) : super(CreateStaffInitial());

  final StaffRepo staffRepo;

  IconData suffixIcon = Icons.visibility_off;
  bool isPassShow = true;

  void changePassVisibility() {
    isPassShow = !isPassShow;
    suffixIcon = isPassShow ? Icons.visibility_off : Icons.visibility;
    emit(ChangePassVisibilityState());
  }

  Future<void> fetchCreateStaff({
    required String name,
    required String email,
    required String number,
    required String password,
    required Uint8List imageBytes,
    required String role,
  }) async {
    emit(CreateStaffLoading());
    var result = await staffRepo.fetchCreateStaff(
      name: name,
      email: email,
      password: password,
      number: number,
      imageBytes: imageBytes,
      role: role,
    );

    result.fold((failure) {
      log(failure.errorMessage);
        emit(CreateStaffFailure(failure.errorMessage));
      }, (createStaff) {
        emit(CreateStaffSuccess(createStaff));
      },
    );
  }
}
