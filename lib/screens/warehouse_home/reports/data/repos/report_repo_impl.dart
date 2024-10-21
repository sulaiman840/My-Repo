import 'dart:developer';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:file_saver/file_saver.dart';

import '../../../../../../constants.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/utils/dio_api_service.dart';
import '../../../../../core/utils/shared_preferences_helper.dart';

import '../models/all_report_model.dart';
import '../models/details_report_model.dart';
import 'report_repo.dart';

class ReportRepoImpl implements ReportRepo {
  final DioApiService dioApiService;
  static var dio = Dio();

  ReportRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, AllReportModel>> fetchAllReports({required int paginate}) async {
    try {
      var data = await (dioApiService.get(
          endPoint: 'reports?paginate=$paginate',
          token: await SharedPreferencesHelper.getJwtToken()
      ));
      log(data.toString());
      AllReportModel allReportModel;
      allReportModel = AllReportModel.fromJson(data);
      List<DataReport> allReport = [];
      for (var item in allReportModel.dataReport!) {
        allReport.add(item);
      }
      return right(allReportModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> fetchCreateReport({
    required String? title,
    required Uint8List? file,
    required String? body,
  }) async {
    FormData formData = FormData.fromMap({
      "title": title,
      "file": MultipartFile.fromBytes(
        file!,
        filename: 'items',
      ),
      "body": body,
    });

    try{
      final token = await SharedPreferencesHelper.getJwtToken();
      dio.options.headers = {
        'Authorization': 'Bearer $token',
      };
      var response =
      await dio.post("http://127.0.0.1:8000/api/reports", data: formData);

      if (response.statusCode != null && response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        log(response.toString());
        return right(response.data);
      } else {
        throw Exception(
            'Registration failed with status: ${response.statusCode}');
      }
    } catch (e) {
      //throw left(ServerFailure.fromDioError(e));
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> fetchDeleteReport({required int id}) async {
    try {
      var data = await (dioApiService.delete(
          endPoint: 'reports/$id',
          data: {},
          token: await SharedPreferencesHelper.getJwtToken()
      ));
      log(data.toString());
      return right(data);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DetailsReportModel>> fetchReportById({required int id}) async {
    try {
      var data = await (dioApiService.get(
          endPoint: 'reports/$id',
          token: await SharedPreferencesHelper.getJwtToken()
      ));
      log(data.toString());
      DetailsReportModel detailsReportModel;
      detailsReportModel = DetailsReportModel.fromJson(data);
      return right(detailsReportModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> fetchUpdateReport({
    required int id,
    required String? title,
    required Uint8List? file,
    required String? body}) async {
    try{
      var data = await (dioApiService.put(
          endPoint: 'reports/$id',
          data: {
            "title": title,
            "file": file,
            "body": body,
          },
          token: await SharedPreferencesHelper.getJwtToken()
      ));
      log(data.toString());
      //UpdateItemModel updateItemModel;
      //updateItemModel = UpdateItemModel.fromJson(data);
      return right("updateItemModel");
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> fetchFile({
    required int id,
    required String ext,
  }) async {
    try{
      final token = await SharedPreferencesHelper.getJwtToken();

      dio.options.headers = {
        'Authorization': 'Bearer $token',
      };

      var response = await dio.get(
        "http://127.0.0.1:8000/api/reports/$id/file",
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        final contentDisposition = response.headers['content-disposition']?.first;
        final filename = contentDisposition?.split('filename=')[1] ?? 'data';
        final bytes = response.data as Uint8List;

        await FileSaver.instance.saveFile(
          name: filename,
          bytes: bytes,
          ext: ext,
          mimeType: MimeType.microsoftExcel,
        );

        log('File saved successfully: $filename');
        return right(response);
      } else {
        log("HELLO");
        throw Exception('Export failed with status: ${response.statusCode}');
      }
    } catch (e) {
      log("HELLO1");
      log(e.toString());
      //throw left(ServerFailure.fromDioError(e));
      return left(ServerFailure(e.toString()));
    }
  }
}