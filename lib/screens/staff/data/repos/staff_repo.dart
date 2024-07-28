import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/create_staff_model.dart';
import '../models/delete_staff_model.dart';
import '../models/show_all_staff_model.dart';
import '../models/show_staff_details_model.dart';
import '../models/update_staff_model.dart';

abstract class StaffRepo {
  Future<Either<Failure, List<ShowAllStaffModel>>> fetchAllStaffs();
  Future<Either<Failure, CreateStaffModel>> fetchCreateStaff({
    required String name,
    required String email,
    required String number,
    required String password,
    required Uint8List imageBytes,
    required String role,
});
  Future<Either<Failure, DeleteStaffModel>> fetchDeleteStaff({
  required int id,
});

  Future<Either<Failure, List<ShowStaffDetailsModel>>> fetchShowStaffDetails({
    required int id,
  });

  Future<Either<Failure, UpdateStaffModel>> fetchUpdateStaff({
    required int id,
    required String name,
    required String email,
    required String number,
    required String password,
    required Uint8List imageBytes,
    required String role,
  });
}