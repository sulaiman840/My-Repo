import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../models/create_type_model.dart';
import '../models/get_all_type_model.dart';
import '../models/get_type_id_model.dart';

abstract class TypeRepo {
  Future<Either<Failure, List<GetAllTypeModel>>> fetchAllTypes();
  Future<Either<Failure, CreateTypeModel>> fetchCreateType({
    required String name,
  });
  Future<Either<Failure, dynamic>> fetchDeleteType({
    required int id,
  });

  Future<Either<Failure, GetTypeIdModel>> fetchTypeById({
    required int id,
  });
}