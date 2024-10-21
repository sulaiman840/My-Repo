import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../../../../core/errors/failures.dart';
import '../models/all_report_model.dart';
import '../models/details_report_model.dart';

abstract class ReportRepo {
  Future<Either<Failure, AllReportModel>> fetchAllReports({
    required int paginate,
  });

  Future<Either<Failure, dynamic>> fetchCreateReport({
    required String? title,
    required Uint8List? file,
    required String? body,
  });

  Future<Either<Failure, dynamic>> fetchDeleteReport({
    required int id,
  });

  Future<Either<Failure, dynamic>> fetchUpdateReport({
    required int id,
    required String? title,
    required Uint8List? file,
    required String? body,
  });

  Future<Either<Failure, DetailsReportModel>> fetchReportById({
    required int id,
  });

  Future<Either<Failure, dynamic>> fetchFile({
    required int id,
    required String ext,
  });
}