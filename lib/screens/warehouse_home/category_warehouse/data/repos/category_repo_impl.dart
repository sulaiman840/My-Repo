import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../constants.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/utils/dio_api_service.dart';
import '../models/accept_request_model.dart';
import '../models/all_request_category_model.dart';
import '../models/all_request_item_model.dart';
import '../models/create_category_model.dart';
import '../models/get_all_category_model.dart';
import '../models/get_category_id_model.dart';
import '../models/reject_request_model.dart';
import '../models/update_category_model.dart';
import 'category_repo.dart';

class CategoryRepoImpl implements CategoryRepo {
  final DioApiService dioApiService;

  CategoryRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, List<GetAllCategoryModel>>> fetchAllCategories() async {
    try {
      var data = await (dioApiService.get(
          endPoint: 'categories',
          token: await Constants.token
      ));
      log(data.toString());
      List<GetAllCategoryModel> getAllCategoryModel = [];
      for (var item in data) {
        getAllCategoryModel.add(GetAllCategoryModel.fromJson(item));
      }
      return right(getAllCategoryModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetCategoryIdModel>> fetchCategoryById({required int id}) async {
    try {
      var data = await (dioApiService.get(
          endPoint: 'categories/$id',
          token: await Constants.token
      ));
      log(data.toString());
      GetCategoryIdModel getCategoryIdModel;
      getCategoryIdModel = GetCategoryIdModel.fromJson(data);
      return right(getCategoryIdModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CreateCategoryModel>> fetchCreateCategory({required String name, required int parentId}) async {
    try{
      var data = await (dioApiService.post(
          endPoint: 'categories',
          data: {
            "name": name,
            "parent_id": parentId,
          },
          token: await Constants.token
      ));
      log(data.toString());
      CreateCategoryModel createCategoryModel;
      createCategoryModel = CreateCategoryModel.fromJson(data);
      return right(createCategoryModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> fetchDeleteCategory({required int id}) async {
    try {
      var data = await (dioApiService.delete(
          endPoint: 'categories/$id',
          data: {},
          token: await Constants.token
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
  Future<Either<Failure, UpdateCategoryModel>> fetchUpdateCategory({required int id, required String name}) async {
    try{
      var data = await (dioApiService.put(
          endPoint: 'categories/$id?name=$name test',
          data: {},
          token: await Constants.token
      ));
      log(data.toString());
      UpdateCategoryModel updateCategoryModel;
      updateCategoryModel = UpdateCategoryModel.fromJson(data);
      return right(updateCategoryModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AcceptRequestModel>> fetchAcceptRequest({required int id}) async {
    try{
      var data = await (dioApiService.post(
          endPoint: 'approverequest/$id',
          data: {},
          token: await Constants.token
      ));
      log(data.toString());
      AcceptRequestModel acceptRequestModel;
      acceptRequestModel = AcceptRequestModel.fromJson(data);
      return right(acceptRequestModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AllRequestCategoryModel>> fetchRequestCategories() async {
    try {
      var data = await (dioApiService.get(
          endPoint: 'showAllRequestcategory',
          token: await Constants.token
      ));
      log(data.toString());
      AllRequestCategoryModel allRequestCategoryModel;
      allRequestCategoryModel = AllRequestCategoryModel.fromJson(data);
      return right(allRequestCategoryModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RejectRequestModel>> fetchRejectRequest({required int id}) async {
    try{
      var data = await (dioApiService.post(
          endPoint: 'rejectrequest/$id',
          data: {},
          token: await Constants.token
      ));
      log(data.toString());
      RejectRequestModel rejectRequestModel;
      rejectRequestModel = RejectRequestModel.fromJson(data);
      return right(rejectRequestModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AllRequestItemModel>> fetchRequestItems() async {
    try {
      var data = await (dioApiService.get(
          endPoint: 'showAllRequestItems',
          token: await Constants.token
      ));
      log(data.toString());
      AllRequestItemModel allRequestItemModel;
      allRequestItemModel = AllRequestItemModel.fromJson(data);
      return right(allRequestItemModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }
}