import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../constants.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/utils/dio_api_service.dart';
import '../../../../../core/utils/shared_preferences_helper.dart';
import '../../../../../models/notification_data.dart';
import '../../../../../services/notification_service.dart';
import '../../../../../services/token_service.dart';
import '../models/create_category_model.dart';
import '../models/get_all_category_model.dart';
import '../models/get_category_id_model.dart';
import '../models/update_category_model.dart';
import 'category_repo.dart';

class CategoryRepoImpl implements CategoryRepo {
  final DioApiService dioApiService;
  final TokenService _tokenService = TokenService();
  final NotificationService _notificationService = NotificationService();


  CategoryRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, List<GetAllCategoryModel>>> fetchAllCategories() async {
    try {
      var data = await (dioApiService.get(
          endPoint: 'categories',
          token: await SharedPreferencesHelper.getJwtToken()
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
          token: await SharedPreferencesHelper.getJwtToken()
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
          data: parentId == -1 ? {
            "name": name,
          }
          : {
            "name": name,
            "parent_id": parentId,
          },
          token: await SharedPreferencesHelper.getJwtToken()
      )

      );
      log(data.toString());
      CreateCategoryModel createCategoryModel;
      //tttttttttttttt
      String accessToken = await _tokenService.fetchAccessToken();
      String? managerFcmToken = await _tokenService.fetchFcmTokenByRole('manager');

      final bool? manager_falge = await SharedPreferencesHelper.getCheckFlag();

      print(managerFcmToken);
      //     print(SecetaryFcmToken);
      print(manager_falge);

      if (managerFcmToken != null && manager_falge==true) {
        // Send the notification
        await _notificationService.sendNotification(accessToken, managerFcmToken);
        print('Notification has been sent to Manager FCM token successfully');

      } else {
        // print('Manager Device is not turned on yet');
        print('hhhhhhhh');
      }
      if (managerFcmToken != null) {
        // Store the notification
        NotificationData notification = NotificationData(
          fcmToken: managerFcmToken,
          title: 'New Category Request ',
          body: 'Warehouse guard Added a new Category',
        );

        await _tokenService.storeNotification(notification);}


      print('Category added successfully.');


      //tttttttttttttt
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
  Future<Either<Failure, UpdateCategoryModel>> fetchUpdateCategory({required int id, required String name}) async {
    try{
      var data = await (dioApiService.put(
          endPoint: 'categories/$id?name=$name',
          data: {},
          token: await SharedPreferencesHelper.getJwtToken()
      ));
      log(data.toString());
      UpdateCategoryModel updateCategoryModel;
      updateCategoryModel = UpdateCategoryModel.fromJson(data);
      //tttttttttttttt
      String accessToken = await _tokenService.fetchAccessToken();
      String? managerFcmToken = await _tokenService.fetchFcmTokenByRole('manager');

      final bool? manager_falge = await SharedPreferencesHelper.getCheckFlag();

      print(managerFcmToken);
      //     print(SecetaryFcmToken);
      print(manager_falge);

      if (managerFcmToken != null && manager_falge==true) {
        // Send the notification
        await _notificationService.sendNotification(accessToken, managerFcmToken);
        print('Notification has been sent to Manager FCM token successfully');

      } else {
        // print('Manager Device is not turned on yet');
        print('hhhhhhhh');
      }
      if (managerFcmToken != null) {
        // Store the notification
        NotificationData notification = NotificationData(
          fcmToken: managerFcmToken,
          title: 'New Update Category Request ',
          body: 'Warehouse guard request to update a Category',
        );

        await _tokenService.storeNotification(notification);}


      print('Category updated successfully.');


      //tttttttttttttt

      return right(updateCategoryModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }
}