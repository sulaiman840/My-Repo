import 'package:dartz/dartz.dart';
import 'package:project2/screens/Manager_Screens/warehouse/categories/data/models/create_category_model.dart';
import 'package:project2/screens/Manager_Screens/warehouse/categories/data/models/get_category_id_model.dart';
import 'package:project2/screens/Manager_Screens/warehouse/categories/data/models/reject_category_model.dart';
import 'package:project2/screens/Manager_Screens/warehouse/categories/data/models/un_available_category_model.dart';

import '../../../../../../core/errors/failures.dart';
import '../models/accept_category_model.dart';
import '../models/available_category_model.dart';
import '../models/get_all_mategory_model.dart';

abstract class CategoryRepo {
  Future<Either<Failure, List<GetAllCategoryModel>>> fetchAllCategories();

  Future<Either<Failure, CreateCategoryModel>> fetchCreateCategory({
    required String name,
    required int parentId,
  });

  Future<Either<Failure, dynamic>> fetchDeleteCategory({
    required int id,
  });

  Future<Either<Failure, GetCategoryIdModel>> fetchCategoryById({
    required int id,
  });

  Future<Either<Failure, List<AvailableCategoryModel>>> fetchAvailableCategories();

  Future<Either<Failure, List<UnAvailableCategoryModel>>> fetchUnAvailableCategories();

  Future<Either<Failure, AcceptCategoryModel>> fetchAcceptCategory({
    required int id,
  });

  Future<Either<Failure, RejectCategoryModel>> fetchRejectCategory({
    required int id,
  });
}