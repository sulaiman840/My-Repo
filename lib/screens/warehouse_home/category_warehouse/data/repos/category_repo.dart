import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../models/accept_request_model.dart';
import '../models/all_request_category_model.dart';
import '../models/all_request_item_model.dart';
import '../models/create_category_model.dart';
import '../models/get_all_category_model.dart';
import '../models/get_category_id_model.dart';
import '../models/reject_request_model.dart';
import '../models/update_category_model.dart';

abstract class CategoryRepo {
  Future<Either<Failure, List<GetAllCategoryModel>>> fetchAllCategories();

  Future<Either<Failure, CreateCategoryModel>> fetchCreateCategory({
    required String name,
    required int parentId,
  });

  Future<Either<Failure, dynamic>> fetchDeleteCategory({
    required int id,
  });

  Future<Either<Failure, UpdateCategoryModel>> fetchUpdateCategory({
    required int id,
    required String name,
  });

  Future<Either<Failure, GetCategoryIdModel>> fetchCategoryById({
    required int id,
  });

  Future<Either<Failure, AllRequestCategoryModel>> fetchRequestCategories();

  Future<Either<Failure, AllRequestItemModel>> fetchRequestItems();

  Future<Either<Failure, AcceptRequestModel>> fetchAcceptRequest({
    required int id,
  });

  Future<Either<Failure, RejectRequestModel>> fetchRejectRequest({
    required int id,
  });
}