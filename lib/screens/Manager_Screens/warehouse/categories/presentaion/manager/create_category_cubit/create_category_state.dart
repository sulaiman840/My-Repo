import 'package:equatable/equatable.dart';

import '../../../data/models/create_category_model.dart';

abstract class CreateCategoryState extends Equatable {
  const CreateCategoryState();

  @override
  List<Object> get props => [];
}

class CreateCategoryInitial extends CreateCategoryState {}
class CreateCategoryLoading extends CreateCategoryState {}
class CreateCategoryFailure extends CreateCategoryState {
  final String errorMessage;

  const CreateCategoryFailure(this.errorMessage);
}
class CreateCategorySuccess extends CreateCategoryState {
  final CreateCategoryModel createResult;

  const CreateCategorySuccess(this.createResult);
}