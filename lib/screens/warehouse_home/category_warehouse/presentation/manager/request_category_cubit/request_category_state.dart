import 'package:equatable/equatable.dart';

import '../../../data/models/all_request_category_model.dart';

abstract class RequestCategoryState  extends Equatable {
  const RequestCategoryState();

  @override
  List<Object> get props => [];
}

class RequestCategoryInitial extends RequestCategoryState {}
class RequestCategoryLoading extends RequestCategoryState {}
class RequestCategoryFailure extends RequestCategoryState {
  final String errorMessage;

  const RequestCategoryFailure(this.errorMessage);
}
class RequestCategorySuccess extends RequestCategoryState {
  final AllRequestCategoryModel allRequestCategories;

  const RequestCategorySuccess(this.allRequestCategories);
}