import 'package:equatable/equatable.dart';

import '../../../data/models/expired_items_model.dart';

abstract class ExpiredState  extends Equatable {
  const ExpiredState();

  @override
  List<Object> get props => [];
}

class IncreasePaginateSuccess extends ExpiredState {}

class ExpiredItemsInitial extends ExpiredState {}
class ExpiredItemsLoading extends ExpiredState {}
class ExpiredItemsFailure extends ExpiredState {
  final String errorMessage;

  const ExpiredItemsFailure(this.errorMessage);
}
class ExpiredItemsSuccess extends ExpiredState {
  final ExpiredItemsModel allItemsExpired;

  const ExpiredItemsSuccess(this.allItemsExpired);
}