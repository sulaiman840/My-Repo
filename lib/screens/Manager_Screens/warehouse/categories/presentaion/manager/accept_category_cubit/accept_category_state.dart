import 'package:equatable/equatable.dart';

import '../../../data/models/accept_category_model.dart';

abstract class AcceptCategoryState  extends Equatable {
  const AcceptCategoryState();

  @override
  List<Object> get props => [];
}

class AcceptCategoryInitial extends AcceptCategoryState {}
class AcceptCategoryLoading extends AcceptCategoryState {}
class AcceptCategoryFailure extends AcceptCategoryState {
  final String errorMessage;

  const AcceptCategoryFailure(this.errorMessage);
}
class AcceptCategorySuccess extends AcceptCategoryState {
  final AcceptCategoryModel acceptResult;

  const AcceptCategorySuccess(this.acceptResult);
}