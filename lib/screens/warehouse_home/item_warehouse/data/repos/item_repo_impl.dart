import 'dart:developer';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:file_saver/file_saver.dart';

import '../../../../../../constants.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/utils/dio_api_service.dart';
import '../../../../../core/utils/shared_preferences_helper.dart';
import '../../../../../models/notification_data.dart';
import '../../../../../services/notification_service.dart';
import '../../../../../services/token_service.dart';
import '../models/all_items_model.dart';
import '../models/consume_item_model.dart';
import '../models/create_item_model.dart';
import '../models/expired_items_model.dart';
import '../models/expiring_soon_items_model.dart';
import '../models/item_by_id_model.dart';
import '../models/search_items_model.dart';
import '../models/update_item_model.dart';
import 'item_repo.dart';

class ItemRepoImpl implements ItemRepo {
  final DioApiService dioApiService;
  static var dio = Dio();
  final TokenService _tokenService = TokenService();
  final NotificationService _notificationService = NotificationService();

  ItemRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, AllItemsModel>> fetchAllItems({
    required int paginate,
  }) async {
    try {
      var data = await (dioApiService.get(
          endPoint: 'items?paginate=$paginate',
          token: await SharedPreferencesHelper.getJwtToken()
      ));
      log(data.toString());
      AllItemsModel allItemsModel;
      allItemsModel = AllItemsModel.fromJson(data);
      List<DataView> allItems = [];
      for (var item in allItemsModel.dataView!) {
        allItems.add(item);
      }
      return right(allItemsModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CreateItemModel>> fetchCreateItem({
    required String name,
    required int typeId,
    required int categoryId,
    required int quantity,
    required String description,
    required String? expiredDate,
    required int? minimumQuantity
  }) async {
    try{
      var data = await (dioApiService.post(
          endPoint: 'items',
          data: minimumQuantity != null ? {
            "name": name,
            "type_id": typeId,
            "category_id": categoryId,
            "quantity": quantity,
            "description": description,
            "expired_date": expiredDate,
            "minimum_quantity": minimumQuantity,
          }
              : expiredDate != null ? {
            "name": name,
            "type_id": typeId,
            "category_id": categoryId,
            "quantity": quantity,
            "description": description,
            "expired_date": expiredDate,
            "minimum_quantity": minimumQuantity,
          }
              : {
            "name": name,
            "type_id": typeId,
            "category_id": categoryId,
            "quantity": quantity,
            "description": description,
          },
          token: await SharedPreferencesHelper.getJwtToken()
      ));
      log(data.toString());
      CreateItemModel createItemModel;

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
          title: 'New Item Request',
          body: 'Warehouse guard Added a new Item',
        );

        await _tokenService.storeNotification(notification);}


      print('a new Item added successfully.');


      //tttttttttttttt
      createItemModel = CreateItemModel.fromJson(data);

      return right(createItemModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> fetchDeleteItem({required int id}) async {
    try {
      var data = await (dioApiService.delete(
          endPoint: 'items/$id',
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
  Future<Either<Failure, ItemByIdModel>> fetchItemById({required int id}) async {
    try {
      var data = await (dioApiService.get(
          endPoint: 'items/$id',
          token: await SharedPreferencesHelper.getJwtToken()
      ));
      log(data.toString());
      ItemByIdModel itemByIdModel;
      itemByIdModel = ItemByIdModel.fromJson(data);
      return right(itemByIdModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateItemModel>> fetchUpdateItem({
    required int id,
    required String name,
    required String? expiredDate,
    required int quantity,
    required String description,
    required int typeId,
    required int categoryId
  }) async {
    try{
      var data = await (dioApiService.put(
          endPoint: 'items/$id',
          data: expiredDate != null ? {
            "name": name,
            "expired_date": expiredDate,
            "quantity": quantity,
            "description": description,
            "type_id": typeId,
            "category_id": categoryId,
          }
              : {
            "name": name,
            "quantity": quantity,
            "description": description,
            "type_id": typeId,
            "category_id": categoryId,
          },
          token: await SharedPreferencesHelper.getJwtToken()
      ));
      log(data.toString());
      UpdateItemModel updateItemModel;
      updateItemModel = UpdateItemModel.fromJson(data);

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
          title: 'New Update Item Request',
          body: 'Warehouse guard request to Update an Item',
        );

        await _tokenService.storeNotification(notification);}


      print('a new Item updated successfully.');


      //tttttttttttttt
      return right(updateItemModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SearchItemsModel>> fetchSearchItem({
    required String name,
    required int typeId,
    required int categoryId,
    required int status,
    required int minQuantity,
    required int maxQuantity,
    required int paginate,
  }) async {
    try{
      var data = await (dioApiService.post(
          endPoint: 'items/advancedSearch',
          data: {
            "name": name,
            "type_id": typeId,
            "category_id": categoryId,
            "status": status,
            "min_quantity": minQuantity,
            "max_quantity": maxQuantity,
            "paginate": paginate,
          },
          token: await SharedPreferencesHelper.getJwtToken()
      ));
      log(data.toString());
      SearchItemsModel searchItemsModel;
      searchItemsModel = SearchItemsModel.fromJson(data);
      List<DataSearch> searchItems = [];
      for (var item in searchItemsModel.dataSearch!) {
        searchItems.add(item);
      }
      return right(searchItemsModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> fetchImportFromExcel({
    required Uint8List excelFile

  }) async {
    FormData formData = FormData.fromMap({
      "excel_file": MultipartFile.fromBytes(
        excelFile,
        filename: 'items.xlsx',
      ),
    });

    try{
      final token = await SharedPreferencesHelper.getJwtToken();
      dio.options.headers = {
        'Authorization': 'Bearer $token',
      };
      var response =
      await dio.post("http://127.0.0.1:8000/api/items/import/excel", data: formData);

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
  Future<Either<Failure, dynamic>> fetchExportToExcel({
    required List<String> fields
  }) async {
    try{
      final token = await SharedPreferencesHelper.getJwtToken();

      dio.options.headers = {
        'Authorization': 'Bearer $token',
      };

      var response = await dio.post(
        "http://127.0.0.1:8000/api/items/export/excel",
        data: {
          "fields": fields,
        },
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        final contentDisposition = response.headers['content-disposition']?.first;
        final filename = contentDisposition?.split('filename=')[1] ?? 'data';
        final bytes = response.data as Uint8List;

        await FileSaver.instance.saveFile(
          name: filename,
          bytes: bytes,
          ext: "xlsx",
          mimeType: MimeType.microsoftExcel,
        );

        log('File saved successfully: $filename');
        return right("r");
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

  @override
  Future<Either<Failure, ConsumeItemModel>> fetchConsumeItem({
    required int id,
    required int quantityConsume,
  }) async {
    try{
      var data = await (dioApiService.post(
          endPoint: 'items/cunsumeItem/$id',
          data: {
            "quantityCunsume": quantityConsume,
          },
          token: await SharedPreferencesHelper.getJwtToken()
      ));
      log(data.toString());
      ConsumeItemModel consumeItemModel;
      consumeItemModel = ConsumeItemModel.fromJson(data);
      return right(consumeItemModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ExpiringSoonItemsModel>> fetchExpiringSoonItems({
    required int paginate,
  }) async {
    try {
      var data = await (dioApiService.get(
          endPoint: 'items/expiring-soon?paginate=$paginate',
          token: await SharedPreferencesHelper.getJwtToken()
      ));
      log(data.toString());
      ExpiringSoonItemsModel expiringSoonItemsModel;
      expiringSoonItemsModel = ExpiringSoonItemsModel.fromJson(data);
      List<DataExpiring> expiringSoonItems = [];
      for (var item in expiringSoonItemsModel.dataExpiring!) {
        expiringSoonItems.add(item);
      }
      return right(expiringSoonItemsModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ExpiredItemsModel>> fetchExpiredItems({
    required int paginate,
  }) async {
    try {
      var data = await (dioApiService.get(
          endPoint: 'items/expired?paginate=$paginate',
          token: await SharedPreferencesHelper.getJwtToken()
      ));
      log(data.toString());
      ExpiredItemsModel expiredItemsModel;
      expiredItemsModel = ExpiredItemsModel.fromJson(data);
      List<DataExpired> expiredItems = [];
      for (var item in expiredItemsModel.dataExpired!) {
        expiredItems.add(item);
      }

      return right(expiredItemsModel);
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> fetchCheckExpiring() async {
    try {
      var data = await (dioApiService.get(
          endPoint: 'items/check-expiring',
          token: await SharedPreferencesHelper.getJwtToken()
      ));
      log(data.toString());
      //ExpiredItemsModel expiredItemsModel;
      //expiredItemsModel = ExpiredItemsModel.fromJson(data);

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
          title: 'Alert About Warehouse',
          body: 'There are items that are expired or close to it.',
        );

        await _tokenService.storeNotification(notification);}


      print('Alarm sent successfully.');


      //tttttttttttttt



      return right("expiredItemsModel");
    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }
}