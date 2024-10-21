import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../../../../core/errors/failures.dart';
import '../models/all_items_model.dart';
import '../models/consume_item_model.dart';
import '../models/create_item_model.dart';
import '../models/expired_items_model.dart';
import '../models/expiring_soon_items_model.dart';
import '../models/item_by_id_model.dart';
import '../models/search_items_model.dart';
import '../models/update_item_model.dart';

abstract class ItemRepo {
  Future<Either<Failure, AllItemsModel>> fetchAllItems({
    required int paginate,
  });

  Future<Either<Failure, CreateItemModel>> fetchCreateItem({
    required String name,
    required int typeId,
    required int categoryId,
    required int quantity,
    required String description,
    required String? expiredDate,
    required int? minimumQuantity,
  });

  Future<Either<Failure, dynamic>> fetchDeleteItem({
    required int id,
  });

  Future<Either<Failure, UpdateItemModel>> fetchUpdateItem({
    required int id,
    required String name,
    required String expiredDate,
    required int quantity,
    required String description,
    required int typeId,
    required int categoryId,
  });

  Future<Either<Failure, ItemByIdModel>> fetchItemById({
    required int id,
  });

  Future<Either<Failure, SearchItemsModel>> fetchSearchItem({
    required String name,
    required int typeId,
    required int categoryId,
    required int status,
    required int minQuantity,
    required int maxQuantity,
    required int paginate,
  });

  Future<Either<Failure, dynamic>> fetchImportFromExcel({
    required Uint8List excelFile,
  });

  Future<Either<Failure, dynamic>> fetchExportToExcel({
    required List<String> fields,
  });

  Future<Either<Failure, ConsumeItemModel>> fetchConsumeItem({
    required int id,
    required int quantityConsume,
  });

  Future<Either<Failure, ExpiringSoonItemsModel>> fetchExpiringSoonItems({
    required int paginate,
  });

  Future<Either<Failure, ExpiredItemsModel>> fetchExpiredItems({
    required int paginate,
  });

  Future<Either<Failure, dynamic>> fetchCheckExpiring();
}