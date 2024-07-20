import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:project2/constants.dart';
import 'package:project2/core/errors/failures.dart';
import 'package:project2/core/utils/dio_api_service.dart';
import 'package:project2/screens/Manager_Screens/warehouse/categories/data/models/accept_category_model.dart';
import 'package:project2/screens/Manager_Screens/warehouse/categories/data/models/available_category_model.dart';
import 'package:project2/screens/Manager_Screens/warehouse/categories/data/models/create_category_model.dart';
import 'package:project2/screens/Manager_Screens/warehouse/categories/data/models/get_all_mategory_model.dart';
import 'package:project2/screens/Manager_Screens/warehouse/categories/data/models/get_category_id_model.dart';
import 'package:project2/screens/Manager_Screens/warehouse/categories/data/models/reject_category_model.dart';
import 'package:project2/screens/Manager_Screens/warehouse/categories/data/models/un_available_category_model.dart';
import 'package:project2/screens/Manager_Screens/warehouse/categories/data/repos/category_repo.dart';


class CategoryRepoImpl implements CategoryRepo {
  final DioApiService dioApiService;

  CategoryRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, List<GetAllCategoryModel>>> fetchAllCategories() async {
    try {
      var data = await (dioApiService.get(
          endPoint: 'categories',
          token: Constants.token
      ));
      print(data.toString());
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
          token: Constants.token
      ));
      print(data.toString());
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
          token: Constants.token
      ));
      print(data.toString());
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
          token: Constants.token
      ));
      print(data.toString());
      return right(data);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AcceptCategoryModel>> fetchAcceptCategory({required int id}) async {
    try{
      var data = await (dioApiService.post(
          endPoint: 'categories/$id/accept',
          data: {},
          token: Constants.token
      ));
      print(data.toString());
      AcceptCategoryModel acceptCategoryModel;
      acceptCategoryModel = AcceptCategoryModel.fromJson(data);
      return right(acceptCategoryModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AvailableCategoryModel>>> fetchAvailableCategories() async {
    try {
      var data = await (dioApiService.get(
          endPoint: 'categories/available',
          token: Constants.token
      ));
      print(data.toString());
      List<AvailableCategoryModel> availableCategoryModel = [];
      for (var item in data) {
        availableCategoryModel.add(AvailableCategoryModel.fromJson(item));
      }
      return right(availableCategoryModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RejectCategoryModel>> fetchRejectCategory({required int id}) async {
    try{
      var data = await (dioApiService.post(
          endPoint: 'categories/$id/reject',
          data: {},
          token: Constants.token
      ));
      print(data.toString());
      RejectCategoryModel rejectCategoryModel;
      rejectCategoryModel = RejectCategoryModel.fromJson(data);
      return right(rejectCategoryModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UnAvailableCategoryModel>>> fetchUnAvailableCategories() async {
    try {
      var data = await (dioApiService.get(
          endPoint: 'categories/unavailable',
          token: Constants.token
      ));
      print(data.toString());
      List<UnAvailableCategoryModel> unAvailableCategoryModel = [];
      for (var item in data) {
        unAvailableCategoryModel.add(UnAvailableCategoryModel.fromJson(item));
      }
      return right(unAvailableCategoryModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

}