import 'dart:developer';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:file_saver/file_saver.dart';

import '../../../../../../constants.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/utils/dio_api_service.dart';
import '../../../../../core/utils/shared_preferences_helper.dart';
import '../models/all_items_model.dart';
import '../models/create_item_model.dart';
import '../models/item_by_id_model.dart';
import '../models/search_items_model.dart';
import '../models/update_item_model.dart';
import 'item_repo.dart';

class ItemRepoImpl implements ItemRepo {
  final DioApiService dioApiService;
  static var dio = Dio();

  ItemRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, AllItemsModel>> fetchAllItems({
    required int paginate,
  }) async {
    try {
      var data = await (dioApiService.get(
          endPoint: 'items?paginate=$paginate',
          token: await Constants.token
      ));
      log(data.toString());
      AllItemsModel allItemsModel;
      allItemsModel = AllItemsModel.fromJson(data);
      List<DataView> allItems = [];
      for (var item in allItemsModel.dataView) {
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
    required String expiredDate,
    required int minimumQuantity
  }) async {
    try{
      var data = await (dioApiService.post(
          endPoint: 'items',
          data: {
            "name": name,
            "type_id": typeId,
            "category_id": categoryId,
            "quantity": quantity,
            "description": description,
            "expired_date": expiredDate,
            "minimum_quantity": minimumQuantity,
          },
          token: await Constants.token
      ));
      log(data.toString());
      CreateItemModel createItemModel;
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
  Future<Either<Failure, ItemByIdModel>> fetchItemById({required int id}) async {
    try {
      var data = await (dioApiService.get(
          endPoint: 'items/$id',
          token: await Constants.token
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
    required String expiredDate,
    required int quantity,
    required String description,
    required int typeId,
    required int categoryId
  }) async {
    try{
      var data = await (dioApiService.put(
          endPoint: 'items/$id',
          data: {
            "name": name,
            "expired_date": expiredDate,
            "quantity": quantity,
            "description": description,
            "type_id": typeId,
            "category_id": categoryId,          },
          token: await Constants.token
      ));
      log(data.toString());
      UpdateItemModel updateItemModel;
      updateItemModel = UpdateItemModel.fromJson(data);
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
          token: await Constants.token
      ));
      log(data.toString());
      SearchItemsModel searchItemsModel;
      searchItemsModel = SearchItemsModel.fromJson(data);
      List<DataSearch> searchItems = [];
      for (var item in searchItemsModel.dataSearch) {
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
        print("HELLO");
        throw Exception('Export failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print("HELLO1");
      print(e);
      //throw left(ServerFailure.fromDioError(e));
      return left(ServerFailure(e.toString()));
    }
  }
}