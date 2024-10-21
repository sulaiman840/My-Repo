import 'package:dartz/dartz.dart';

import '../../../../../../core/errors/failures.dart';
import '../models/accept_request_model.dart';
import '../models/all_request_category_model.dart';
import '../models/all_request_item_model.dart';
import '../models/reject_request_model.dart';

abstract class RequestRepo {
  Future<Either<Failure, AllRequestCategoryModel>> fetchRequestCategories();

  Future<Either<Failure, AllRequestItemModel>> fetchRequestItems();

  Future<Either<Failure, AcceptRequestModel>> fetchAcceptRequest({
    required int id,
  });

  Future<Either<Failure, RejectRequestModel>> fetchRejectRequest({
    required int id,
  });
}