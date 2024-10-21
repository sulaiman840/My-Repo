import 'package:equatable/equatable.dart';

import '../../../data/models/expiring_soon_items_model.dart';

abstract class ExpiringSoonState  extends Equatable {
  const ExpiringSoonState();

  @override
  List<Object> get props => [];
}

class IncreasePaginateSuccess extends ExpiringSoonState {}

class ExpiringSoonItemsInitial extends ExpiringSoonState {}
class ExpiringSoonItemsLoading extends ExpiringSoonState {}
class ExpiringSoonItemsFailure extends ExpiringSoonState {
  final String errorMessage;

  const ExpiringSoonItemsFailure(this.errorMessage);
}
class ExpiringSoonItemsSuccess extends ExpiringSoonState {
  final ExpiringSoonItemsModel allItemsExpiring;

  const ExpiringSoonItemsSuccess(this.allItemsExpiring);
}