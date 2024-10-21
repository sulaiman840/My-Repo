import 'package:equatable/equatable.dart';

import '../../../data/models/all_items_model.dart';

abstract class CheckExpiringState  extends Equatable {
  const CheckExpiringState();

  @override
  List<Object> get props => [];
}

class CheckExpiringInitial extends CheckExpiringState {}
class CheckExpiringLoading extends CheckExpiringState {}
class CheckExpiringFailure extends CheckExpiringState {
  final String errorMessage;

  const CheckExpiringFailure(this.errorMessage);
}
class CheckExpiringSuccess extends CheckExpiringState {
  final dynamic checkResult;

  const CheckExpiringSuccess(this.checkResult);
}