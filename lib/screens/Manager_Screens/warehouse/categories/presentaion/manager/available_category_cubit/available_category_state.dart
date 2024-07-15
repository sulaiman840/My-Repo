import 'package:equatable/equatable.dart';

import '../../../data/models/available_category_model.dart';

abstract class AvailableCategoryState  extends Equatable {
  const AvailableCategoryState();

  @override
  List<Object> get props => [];
}

class AvailableCategoryInitial extends AvailableCategoryState {}
class AvailableCategoryLoading extends AvailableCategoryState {}
class AvailableCategoryFailure extends AvailableCategoryState {
  final String errorMessage;

  const AvailableCategoryFailure(this.errorMessage);
}
class AvailableCategorySuccess extends AvailableCategoryState {
  final List<AvailableCategoryModel> allAvailableCategory;

  const AvailableCategorySuccess(this.allAvailableCategory);
}