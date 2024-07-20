import 'package:equatable/equatable.dart';

import '../../../data/models/reject_category_model.dart';

abstract class RejectCategoryState  extends Equatable {
  const RejectCategoryState();

  @override
  List<Object> get props => [];
}

class RejectCategoryInitial extends RejectCategoryState {}
class RejectCategoryLoading extends RejectCategoryState {}
class RejectCategoryFailure extends RejectCategoryState {
  final String errorMessage;

  const RejectCategoryFailure(this.errorMessage);
}
class RejectCategorySuccess extends RejectCategoryState {
  final RejectCategoryModel rejectResult;

  const RejectCategorySuccess(this.rejectResult);
}