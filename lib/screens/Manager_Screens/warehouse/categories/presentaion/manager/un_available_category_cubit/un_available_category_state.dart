import 'package:equatable/equatable.dart';

import '../../../data/models/un_available_category_model.dart';

abstract class UnAvailableCategoryState  extends Equatable {
  const UnAvailableCategoryState();

  @override
  List<Object> get props => [];
}

class UnAvailableCategoryInitial extends UnAvailableCategoryState {}
class UnAvailableCategoryLoading extends UnAvailableCategoryState {}
class UnAvailableCategoryFailure extends UnAvailableCategoryState {
  final String errorMessage;

  const UnAvailableCategoryFailure(this.errorMessage);
}
class UnAvailableCategorySuccess extends UnAvailableCategoryState {
  final List<UnAvailableCategoryModel> allUnAvailableCategory;

  const UnAvailableCategorySuccess(this.allUnAvailableCategory);
}