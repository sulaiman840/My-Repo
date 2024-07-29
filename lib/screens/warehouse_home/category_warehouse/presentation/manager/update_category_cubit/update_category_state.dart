import 'package:equatable/equatable.dart';

import '../../../data/models/update_category_model.dart';

abstract class UpdateCategoryState extends Equatable {
  const UpdateCategoryState();

  @override
  List<Object> get props => [];
}

class UpdateCategoryInitial extends UpdateCategoryState {}
class UpdateCategoryLoading extends UpdateCategoryState {}
class UpdateCategoryFailure extends UpdateCategoryState {
  final String errorMessage;

  const UpdateCategoryFailure(this.errorMessage);
}
class UpdateCategorySuccess extends UpdateCategoryState {
  final UpdateCategoryModel updateResult;

  const UpdateCategorySuccess(this.updateResult);
}