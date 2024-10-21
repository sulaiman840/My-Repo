import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:project2/core/errors/failures.dart';
import 'package:project2/core/utils/dio_api_service.dart';
import 'package:project2/core/utils/shared_preferences_helper.dart';

import '../../../../../constants.dart';
import '../models/create_type_model.dart';
import '../models/get_all_type_model.dart';
import '../models/get_type_id_model.dart';
import 'type_repo.dart';



class TypeRepoImpl implements TypeRepo {
  final DioApiService dioApiService;

  TypeRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, List<GetAllTypeModel>>> fetchAllTypes() async {
    try {
      var data = await (dioApiService.get(
          endPoint: 'types',
          token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      List<GetAllTypeModel> getAllTypeModel = [];
      for (var item in data) {
        getAllTypeModel.add(GetAllTypeModel.fromJson(item));
      }
      return right(getAllTypeModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CreateTypeModel>> fetchCreateType({required String name}) async {
    try{
      var data = await (dioApiService.post(
          endPoint: 'types',
          data: {
            "name": name,
          },
          token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      CreateTypeModel createTypeModel;
      createTypeModel = CreateTypeModel.fromJson(data);
      return right(createTypeModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> fetchDeleteType({required int id}) async {
    try {
      var data = await (dioApiService.delete(
          endPoint: 'types/$id',
          data: {},
          token: await SharedPreferencesHelper.getJwtToken(),
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
  Future<Either<Failure, GetTypeIdModel>> fetchTypeById({required int id}) async {
    try {
      var data = await (dioApiService.get(
          endPoint: 'types/$id',
          token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      GetTypeIdModel getTypeIdModel;
      getTypeIdModel = GetTypeIdModel.fromJson(data);
      return right(getTypeIdModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

}