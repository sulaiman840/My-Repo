import 'package:equatable/equatable.dart';

import '../../../data/models/get_category_id_model.dart';

abstract class CategoryByIdState  extends Equatable {
  const CategoryByIdState();

  @override
  List<Object> get props => [];
}

class CategoryByIdInitial extends CategoryByIdState {}
class CategoryByIdLoading extends CategoryByIdState {}
class CategoryByIdFailure extends CategoryByIdState {
  final String errorMessage;

  const CategoryByIdFailure(this.errorMessage);
}
class CategoryByIdSuccess extends CategoryByIdState {
  final GetCategoryIdModel category;

  const CategoryByIdSuccess(this.category);
}