import 'package:equatable/equatable.dart';

import '../../../data/models/get_all_category_model.dart';

abstract class GetAllCategoryState  extends Equatable {
  const GetAllCategoryState();

  @override
  List<Object> get props => [];
}

class GetAllCategoryInitial extends GetAllCategoryState {}
class GetAllCategoryLoading extends GetAllCategoryState {}
class GetAllCategoryFailure extends GetAllCategoryState {
  final String errorMessage;

  const GetAllCategoryFailure(this.errorMessage);
}
class GetAllCategorySuccess extends GetAllCategoryState {
  final List<GetAllCategoryModel> allCategories;

  const GetAllCategorySuccess(this.allCategories);
}