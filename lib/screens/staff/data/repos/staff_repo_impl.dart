import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:project2/core/errors/failures.dart';
import 'package:project2/core/utils/dio_api_service.dart';
import 'package:project2/screens/staff/data/models/create_staff_model.dart';
import 'package:project2/screens/staff/data/models/show_all_staff_model.dart';
import 'package:project2/screens/staff/data/models/show_staff_details_model.dart';
import 'package:project2/screens/staff/data/repos/staff_repo.dart';

import '../models/delete_staff_model.dart';
import '../models/update_staff_model.dart';


class StaffRepoImpl implements StaffRepo {
  final DioApiService dioApiService;
  static var dio = Dio();

  StaffRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, List<ShowAllStaffModel>>> fetchAllStaffs() async {
    try {
      var data = await (dioApiService.get(
          endPoint: 'showallstaff',
        token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzE4OTk4ODk3LCJleHAiOjE3MzYyNzg4OTcsIm5iZiI6MTcxODk5ODg5NywianRpIjoiSXlDc1Jra05OTUlmYTg4UyIsInN1YiI6IjEiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.6TbxacWg4WVxZBY3eutqQkubtf9ELwQS5YiwZz1heFs"
      ));
    print(data.toString());
      List<ShowAllStaffModel> showAllStaffModel = [];
      for (var item in data) {
        showAllStaffModel.add(ShowAllStaffModel.fromJson(item));
      }
      return right(showAllStaffModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CreateStaffModel>> fetchCreateStaff({
    required String name,
    required String email,
    required String number,
    required String password,
    required String role,
    required Uint8List imageBytes,
  }) async {
    FormData formData = FormData.fromMap({
      "name": name,
      "email": email,
      "number": number,
      "password": password,
      "image": MultipartFile.fromBytes(
        imageBytes,
        filename: 'upload.jpg',
      ),
      "role": role,
    });

    try{
      dio.options.headers = {
        'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzE4OTk4ODk3LCJleHAiOjE3MzYyNzg4OTcsIm5iZiI6MTcxODk5ODg5NywianRpIjoiSXlDc1Jra05OTUlmYTg4UyIsInN1YiI6IjEiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.6TbxacWg4WVxZBY3eutqQkubtf9ELwQS5YiwZz1heFs',
      };
      var response =
      await dio.post("http://127.0.0.1:8000/api/createstaff", data: formData);

      if (response.statusCode != null && response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return right(CreateStaffModel.fromJson(response.data));
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
  Future<Either<Failure, DeleteStaffModel>> fetchDeleteStaff({
    required int id,
  })  async {
    try {
      var data = await (dioApiService.post(
          endPoint: 'destroystaff/$id',
          data: {},
          token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzE4OTk4ODk3LCJleHAiOjE3MzYyNzg4OTcsIm5iZiI6MTcxODk5ODg5NywianRpIjoiSXlDc1Jra05OTUlmYTg4UyIsInN1YiI6IjEiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.6TbxacWg4WVxZBY3eutqQkubtf9ELwQS5YiwZz1heFs"
      ));
      print(data.toString());
      DeleteStaffModel deleteStaffModel;
      deleteStaffModel = DeleteStaffModel.fromJson(data);
      return right(deleteStaffModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ShowStaffDetailsModel>>> fetchShowStaffDetails({
  required int id,
})  async {
    try {
      var data = await (dioApiService.get(
          endPoint: 'showstaff/$id',
          token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzE4OTk4ODk3LCJleHAiOjE3MzYyNzg4OTcsIm5iZiI6MTcxODk5ODg5NywianRpIjoiSXlDc1Jra05OTUlmYTg4UyIsInN1YiI6IjEiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.6TbxacWg4WVxZBY3eutqQkubtf9ELwQS5YiwZz1heFs"
      ));
      print(data.toString());
      List<ShowStaffDetailsModel> showStaffDetailsModel = [];
      for (var item in data) {
        showStaffDetailsModel.add(ShowStaffDetailsModel.fromJson(item));
      }
      return right(showStaffDetailsModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateStaffModel>> fetchUpdateStaff({
    required int id,
    required String name,
    required String email,
    required String number,
    required String password,
    required String role,
    required Uint8List imageBytes,
  }) async {
    FormData formData = FormData.fromMap({
      "name": name,
      "email": email,
      "number": number,
      "password": password,
      "image": MultipartFile.fromBytes(
        imageBytes,
        filename: 'upload.jpg',
      ),
      "role": role,
    });

    try{
      dio.options.headers = {
        'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzE4OTk4ODk3LCJleHAiOjE3MzYyNzg4OTcsIm5iZiI6MTcxODk5ODg5NywianRpIjoiSXlDc1Jra05OTUlmYTg4UyIsInN1YiI6IjEiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.6TbxacWg4WVxZBY3eutqQkubtf9ELwQS5YiwZz1heFs',
      };
      var response =
      await dio.post("http://127.0.0.1:8000/api/updatestaff/$id", data: formData);

      if (response.statusCode != null && response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return right(UpdateStaffModel.fromJson(response.data));
      } else {
        throw Exception(
            'Update failed with status: ${response.statusCode}');
      }
    } catch (e) {
      //throw left(ServerFailure.fromDioError(e));
      return left(ServerFailure(e.toString()));
    }
  }

}