import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:project2/core/errors/failures.dart';
import 'package:project2/core/utils/dio_api_service.dart';
import 'package:project2/screens/Manager_Screens/warehouse/data/models/create_type_model.dart';
import 'package:project2/screens/Manager_Screens/warehouse/data/models/get_all_type_model.dart';
import 'package:project2/screens/Manager_Screens/warehouse/data/models/get_type_id_model.dart';

import 'type_repo.dart';



class TypeRepoImpl implements TypeRepo {
  final DioApiService dioApiService;

  TypeRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, List<GetAllTypeModel>>> fetchAllTypes() async {
    try {
      var data = await (dioApiService.get(
          endPoint: 'types',
          token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzE4OTk4ODk3LCJleHAiOjE3MzYyNzg4OTcsIm5iZiI6MTcxODk5ODg5NywianRpIjoiSXlDc1Jra05OTUlmYTg4UyIsInN1YiI6IjEiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.6TbxacWg4WVxZBY3eutqQkubtf9ELwQS5YiwZz1heFs"
      ));
      print(data.toString());
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
          data: {},
          token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzE4OTk4ODk3LCJleHAiOjE3MzYyNzg4OTcsIm5iZiI6MTcxODk5ODg5NywianRpIjoiSXlDc1Jra05OTUlmYTg4UyIsInN1YiI6IjEiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.6TbxacWg4WVxZBY3eutqQkubtf9ELwQS5YiwZz1heFs"
      ));
      print(data.toString());
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
          token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzE4OTk4ODk3LCJleHAiOjE3MzYyNzg4OTcsIm5iZiI6MTcxODk5ODg5NywianRpIjoiSXlDc1Jra05OTUlmYTg4UyIsInN1YiI6IjEiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.6TbxacWg4WVxZBY3eutqQkubtf9ELwQS5YiwZz1heFs"
      ));
      print(data.statusCode);
      return right(data.statusCode);
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
          token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzE4OTk4ODk3LCJleHAiOjE3MzYyNzg4OTcsIm5iZiI6MTcxODk5ODg5NywianRpIjoiSXlDc1Jra05OTUlmYTg4UyIsInN1YiI6IjEiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.6TbxacWg4WVxZBY3eutqQkubtf9ELwQS5YiwZz1heFs"
      ));
      print(data.toString());
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