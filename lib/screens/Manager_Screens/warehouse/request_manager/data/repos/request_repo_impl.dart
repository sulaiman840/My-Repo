import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../../constants.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/utils/dio_api_service.dart';
import '../models/accept_request_model.dart';
import '../models/all_request_category_model.dart';
import '../models/all_request_item_model.dart';
import '../models/reject_request_model.dart';
import 'request_repo.dart';

class RequestRepoImpl extends RequestRepo {
  final DioApiService dioApiService;

  RequestRepoImpl(this.dioApiService);

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